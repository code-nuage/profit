local jwt = require("jwt")
local json = require("json")
local sha256 = require("../Utils/sha256")

local secret_key = require("../config").secret

local status = require("../Utils/status")
local mime = require("../Utils/mime")
local cookie_builder = require("../Utils/cookie-builder")

local model_user = require("../Models/user")

local controller = {}

function controller.login(json_data)
    local data = json.decode(json_data)

    local data_user = model_user.get_by_email(data.email)

    if not data then
        return status["Internal Server Error"],
        "Can't decode JSON data",
        mime["text"]
    end

    if data_user then
        if sha256(data.password) == data_user.password then
            print(moreutils.table.dump(data))
            print(moreutils.table.dump(data_user))
            local jwt_token = jwt.sign(                                        -- Create the token with hashed password
                {email = data_user.email, password = data_user.password},      -- Don't store clear password in the JWT!
                {secret = secret_key})

            return status["OK"],
            "You are connected",
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

function controller.me(cookie)
    cookie = cookie:gsub("jwt=", "")
    local jwt_token = jwt.verify(cookie, {secret = secret_key})

    local data = model_user.get_by_email(jwt_token.email)

    if data then
        return status["OK"],
        json.encode(data),
        mime["json"]
    end
end

return controller