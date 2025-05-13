local json = require("json")

local status = require("../Utils/status")
local mime = require("../Utils/mime")

local user_model = require("../Models/user")

--+ FORMAT CHECKING HELPERS+--
local function is_valid_date(date)
    if type(date) ~= "string" then return false end
    local year, month, day = date:match("^(%d%d%d%d)%-(%d%d)%-(%d%d)$")
    if not year or not month or not day then
        return false
    end
    year, month, day = tonumber(year), tonumber(month), tonumber(day)
    if not year or not month or not day then
        return false
    end
    return month >= 1 and month <= 12 and day >= 1 and day <= 31
end

local function is_valid_email(email)
    if type(email) ~= "string" then return false end
    return email:match("^[%w%.%-_]+@[%w%-_]+%.%w%w+$") ~= nil
end

local function is_create_format_valid(data)
    if type(data) ~= "table" then
        return false, "Invalid data format", status["Bad Request"]
    end

    if type(data.name) ~= "string" or
    #data.name < 4 or
    #data.name > 16 then
        return false, "Invalid name: must be between 4 and 16 characters", status["Bad Request"]
    end

    if type(data.password) ~= "string" or
    #data.password < 8 or
    #data.password > 24 then
        return false, "Invalid password: must be between 8 and 24 characters", status["Bad Request"]
    end

    if not is_valid_date(data.birthdate) then
        return false, "Invalid birthdate: must be in YYYY-MM-DD format", status["Bad Request"]
    end

    if not is_valid_email(data.email) then
        return false, "Invalid email format"
    end

    if data.role ~= "USER" and data.role ~= "ADMIN" then
        return false, "Invalid role: must be USER or ADMIN", status["Bad Request"]
    end

    return true
end

local function is_update_format_valid(data)
    if type(data) ~= "table" then
        return false, "Invalid data format"
    end

    if data.name and
    (type(data.name) ~= "string" or
    #data.name < 4 or
    #data.name > 16) then
        return false, "Invalid name: must be between 4 and 16 characters"
    end

    if data.password and
    (type(data.password) ~= "string" or
    #data.password < 8 or
    #data.password > 24) then
        return false, "Invalid password: must be between 8 and 24 characters"
    end

    if data.birthdate and not is_valid_date(data.birthdate) then
        return false, "Invalid birthdate: must be in YYYY-MM-DD format"
    end

    if data.email and not is_valid_email(data.email) then
        return false, "Invalid email format"
    end

    if data.role and
    (data.role ~= "USER" and data.role ~= "ADMIN") then
        return false, "Invalid role: must be USER or ADMIN"
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
            local returned_data = user_model.create(data)
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
    "Internal Server Error",
    mime["text"]
end

function controller.read_by_id(id)

end

function controller.read_by_email(res, email)
    
end

return controller