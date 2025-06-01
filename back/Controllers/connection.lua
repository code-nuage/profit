local jwt = require("jwt")
local json = require("json")
local sha256 = require("../Utils/sha256")

local secret_key = require("../config").secret

local status = require("../Utils/status")
local mime = require("../Utils/mime")
local cookie_builder = require("../Utils/cookie-builder")

local controller_user = require("../Controllers/user")

local model_user = require("../Models/user")

local controller = {}

function controller.register(json_data)                                        -- {name = string, email = email, password = password, password_confirm = password, birthdate = YYYY-MM-DD, role = string}
    local data = json.decode(json_data)

    data.role = "USER"

    if model_user.get_by_email(data.email) then
        return status["Conflict"], "User already exists", mime["text"]
    end

    if data.password ~= data.password_confirm then
        return status["Bad Request"], "Passwords must be the same", mime["text"]
    end

    if not data then
        return status["Internal Server Error"],
        "Can't decode JSON data",
        mime["text"]
    end

    local create_status, create_body, create_mime = controller_user.create(json.encode(data))

    if create_status == status["Created"] then
        local data_user = model_user.get_by_email(data.email)

        local jwt_token = jwt.sign(                                            -- Create the token with hashed password
                {email = data_user.email, password = data_user.password},      -- Don't store clear password in the JWT!
                {secret = secret_key})

        return create_status, "Registered as " .. data_user.email, mime["text"], cookie_builder("jwt", jwt_token,
                    {["Path"] = "/",
                    "HttpOnly",
                    "Secure",
                    ["SameSite"] = "None",
                    "Partitioned",
                    ["Max-Age"] = 1000 * 60 * 60 * 24})
    end

    return create_status, create_body, create_mime
end

function controller.login(json_data)                                           -- {email = email, password = password}
    local data = json.decode(json_data)

    local data_user = model_user.get_by_email(data.email)

    if not data then
        return status["Internal Server Error"],
        "Can't decode JSON data",
        mime["text"]
    end

    if data_user then
        if sha256(data.password) == data_user.password then
            local jwt_token = jwt.sign(                                        -- Create the token with hashed password
                {email = data_user.email, password = data_user.password},      -- Don't store clear password in the JWT!
                {secret = secret_key})

            return status["OK"],
            "Connected as " .. data_user.email,
            mime["text"],
            cookie_builder("jwt", jwt_token,
                    {["Path"] = "/",
                    "HttpOnly",
                    "Secure",
                    ["SameSite"] = "None",
                    "Partitioned",
                    ["Max-Age"] = 1000 * 60 * 60 * 24})
        end
        return status["Unauthorized"],
        "Bad password",
        mime["text"]
    else
        return status["Not Found"],
        "User doesn't exists",
        mime["text"]
    end
end

function controller.logout()
    return status["OK"],
    "You are disconnected",
    mime["text"],
    cookie_builder("jwt", "",
                    {["Path"] = "/",
                    "HttpOnly",
                    "Secure",
                    ["SameSite"] = "None",
                    "Partitioned",
                    ["Max-Age"] = 1})
end

function controller.rename(cookie, json_data)
    local data = json.decode(json_data)
    if cookie then
        cookie = cookie:gsub("jwt=", "")

        local jwt_token = jwt.verify(cookie, {secret = secret_key})

        local sent_data = json.encode({name = data.name})

        return controller_user.update_by_email(jwt_token.email, sent_data)
    end
end

function controller.delete(cookie)
    if cookie then
        cookie = cookie:gsub("jwt=", "")

        local jwt_token = jwt.verify(cookie, {secret = secret_key})

        return controller_user.delete_by_email(jwt_token.email)
    end
end

function controller.resetpassword(cookie, json_data)
    local data = json.decode(json_data)
    if cookie then
        cookie = cookie:gsub("jwt=", "")

        local jwt_token = jwt.verify(cookie, {secret = secret_key})

        if data.password == data.passwordConfirm then
            local sent_data = json.encode({password = data.password})

            return controller_user.update_by_email(jwt_token.email, sent_data)
        end
    end
end

function controller.me(cookie)
    if cookie then
        cookie = cookie:gsub("jwt=", "")
        local jwt_token = jwt.verify(cookie, {secret = secret_key})

        local data = model_user.get_by_email(jwt_token.email)

        if data then
            return status["OK"],
            json.encode(data),
            mime["json"]
        end
    end
    return status["Unauthorized"],
    "You are not connected",
    mime["text"]
end

return controller