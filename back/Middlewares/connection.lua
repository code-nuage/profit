local jwt = require("jwt")

local secret_key = require("../config").secret

return function(req)
    local jwt_token = req.headers["cookie"]

    if jwt_token then
        jwt_token, _ = jwt_token:gsub("jwt=", "")

        if jwt_token ~= "" then
            local payload = jwt.verify(jwt_token, {secret = secret_key})

            if payload then
                return true
            end
        end
    end

    return false
end