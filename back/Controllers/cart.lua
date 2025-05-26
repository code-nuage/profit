local json = require("json")

local status = require("../Utils/status")
local mime = require("../Utils/mime")

local model_cart = require("../Models/cart")

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
    if type(data) ~= "string" then
        return false, "Invalid data format", status["Unprocessable Entity"]
    end

    if not data.type and not type(data.type) == "table" then
        return false, "Invalid type", status["Unprocessable Entity"]
    end

    if not data.customs and not type(data.customs) == "table" then
        return false, "Invalid customs", status["Unprocessable Entity"]
    end
end

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

    local existing = model_cart.get_by_email(data.user_email)                  -- Gets the existing cart

    if data then
        local format_validity, error_message, error_code = is_valid_product(data.product)
        if format_validity then
            table.insert(existing.products, data.product)                      -- Inserts the product in existing cart products 
            local returned_data = model_cart.add_product(data.user_email, existing.products)
            return status["OK"],
            returned_data,
            mime["json"]
        end
        return error_code,
        error_message,
        mime["text"]
    end

    return status["Not Found"],
    "Cart with user_email " .. data.user_email .. " doesn't exists",
    mime["text"]
end

function controller.remove_product(json_data)                                  -- {}
    
end

return controller