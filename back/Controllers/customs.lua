local json = require("json")

local status = require("../Utils/status")
local mime = require("../Utils/mime")

local model_customs = require("../Models/customs")

--+ FORMAT CHECKING HELPERS +--
local function is_create_format_valid(data)
    if type(data) ~= "table" then
        return false, "Invalid data format", status["Bad Request"]
    end

    if not data.name or type(data.name) ~= "string" then
        return false, "Invalid name: must be a string", status["Unprocessable Entity"]
    end

    if not data.type_id or type(data.type_id) ~= "number" then
        return false, "Invalid ID: must be an integer", status["Unprocessable Entity"]
    end

    if not model_customs.types.get_by_id(data.type_id) then
        return false, "Invalid ID: Type with ID " .. data.type_id .. " doesn't exists", status["Unprocessable Entity"]
    end

    return true
end

--+ CONTROLLER +--
local controller = {}

function controller.create(json_data)
    local data = json.decode(json_data)

    data.type_id = tonumber(data.type_id)

    if data then
        local format_validity, error_message, error_code = is_create_format_valid(data)
        if format_validity then
            local returned_data = model_customs.create(data)
            return status["Created"],
            json.encode(returned_data),
            mime["json"]
        end

        return error_code,
        error_message,
        mime["text"]
    end

    return status["Internal Server Error"],
    "Internal Server Error",
    mime["text"]
end

function controller.read_by_id(id)
    local data = model_customs.get_by_id(id)

    if data then
        return status["OK"],
        json.encode(data),
        mime["json"]
    end

    return status["Not Found"],
    "Cutom with id " .. id .. " doesn't exists",
    mime["text"]
end

function controller.read_all()
    local data = model_customs.get_all()

    if data then
        return status["OK"],
        json.encode(data),
        mime["json"]
    end

    return status["Not Found"],
    "No custom type found",
    mime["text"]
end

--+ FORMAT CHECKING HELPERS +--
local function is_types_create_format_valid(data)
    if type(data) ~= "table" then
        return false, "Invalid data format", status["Bad Request"]
    end

    if not data.name or type(data.name) ~= "string" then
        return false, "Invalid name: must be a string", status["Unprocessable Entity"]
    end

    return true
end

--+ CONTROLLER +--
controller.types = {}

function controller.types.create(json_data)
    local data = json.decode(json_data)

    if data then
        local format_validity, error_message, error_code = is_types_create_format_valid(data)
        if format_validity then
            local returned_data = model_customs.types.create(data)
            return status["Created"],
            json.encode(returned_data),
            mime["json"]
        end
        return error_code,
        error_message,
        mime["text"]
    end

    return status["Internal Server Error"],
    "Internal Server Error",
    mime["text"]
end

function controller.types.read_by_id(id)
    local data = model_customs.types.get_by_id(id)

    if data then
        return status["OK"],
        json.encode(data),
        mime["json"]
    end

    return status["Not Found"],
    "Cutom type with id " .. id .. " doesn't exists",
    mime["text"]
end

function controller.types.read_all()
    local data = model_customs.types.get_all()

    if data then
        return status["OK"],
        json.encode(data),
        mime["json"]
    end

    return status["Not Found"],
    "No custom type found",
    mime["text"]
end

function controller.types.read_id_by_name(name)
    local data = model_customs.types.get_id_by_name(name)

    if data then
        return status["OK"],
        json.encode({id = data}),
        mime["json"]
    end

    return status["Not Found"],
    "Custom type with name " .. name .. " doesn't exists",
    mime["text"]
end

return controller
