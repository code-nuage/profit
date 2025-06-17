local json = require("json")

local status = require("../Utils/status")
local mime = require("../Utils/mime")

local model_cart = require("../Models/cart")
local model_customs = require("../Models/customs")

--+ FORMAT CHECKING HELPERS +--
local function is_valid_email(email)
    if type(email) ~= "string" then return false end
    return email:match("^[%w%.%-_]+@[%w%-_]+%.%w%w+$") ~= nil
end

local function is_create_format_valid(data)
    if type(data) ~= "table" then
        return false, "Invalid data format", status["Bad Request"]
    end

    if not data.user_email or not is_valid_email(data.user_email) then
        return false, "Invalid email format"
    end

    return true
end

local function is_valid_product(data)
    if type(data) ~= "table" then
        return false, "Invalid data format", status["Unprocessable Entity"]
    end

    if not data.customs and not type(data.customs) == "table" then
        return false, "Invalid customs", status["Unprocessable Entity"]
    end

    return true
end

--+ CONTROLLER +--
local controller = {}

function controller.create(json_data)
    local data = json.decode(json_data)

    if data then
        local format_validity, error_message, error_code = is_create_format_valid(data)
        if format_validity then
            local returned_data = model_cart.create(data)
            return status["Created"],
            json.encode(returned_data),
            mime["json"]
        else
            return error_code,
            error_message,
            mime["text"]
        end
    end

    return status["Internal Server Error"],
    "Can't decode JSON data",
    mime["text"]
end

function controller.read_by_email(user_email)
    local data = model_cart.get_by_email(user_email)

    if data then
        return status["OK"],
        json.encode(data),
        mime["json"]
    end

    return status["Not Found"],
    "Cart with user_email " .. user_email .. " doesn't exists",
    mime["text"]
end

function controller.insert_product(json_data)                                  -- {user_email = string, product = table}
    local data = json.decode(json_data)

    local existing = model_cart.get_by_email(data.user_email) or
    model_cart.create({user_email = data.user_email})                          -- Gets the existing cart or create one

    if data then
        local format_validity, error_message, error_code = is_valid_product(data.product)


        if format_validity then
            for custom_type, custom in pairs(data.product.customs) do
                data.product.customs[custom_type] = model_customs.get_id_by_name(custom)
            end

            print(moreutils.table.dump(data))
            
            table.insert(existing.products, data.product)                      -- Inserts the product in existing cart products
            local returned_data = model_cart.add_product(data.user_email, existing.products)

            return status["OK"],
            json.encode(returned_data),
            mime["json"]
        end
        return error_code,
        error_message,
        mime["text"]
    end

    return status["Internal Server Error"],
    "Can't decode json data",
    mime["text"]
end

function controller.remove_product(json_data)                                  -- {}
    
end

controller.status = {}

local function is_status_format_valid(data)
    if type(data) ~= "table" then
        return false, "Invalid data format", status["Bad Request"]
    end

    if not data.name then
        return false, "Invalid status format"
    end

    return true
end

function controller.status.create(json_data)
    local data = json.decode(json_data)

    local format_validity, error_message = is_status_format_valid(data)

    if format_validity then
        local returned_data = model_cart.status.create(data)
        return status["Created"],
        json.encode(returned_data),
        mime["json"]
    end

    return status["Bad Request"],
    error_message,
    mime["text"]
end

function controller.status.read_by_id(id)
    local data = model_cart.status.get_by_id(id)

    if data then
        return status["OK"],
        json.encode(data),
        mime["json"]
    end

    return status["Not Found"],
    "Cart status with id " .. id .. " not found",
    mime["text"]
end

function controller.status.delete_by_id(id)
    local data = model_cart.status.delete_by_id(id)

    if data then
        return status["Reset Content"],
        "Cart status with id " .. id .. " deleted",
        mime["text"]
    end

    return status["Not Found"],
    "Cart status with id " .. id .. " doesn't exists",
    mime["text"]
end

return controller