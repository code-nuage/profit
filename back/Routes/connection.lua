local status = require("../Utils/status")
local mime = require("../Utils/mime")

local controller_connection = require("../Controllers/connection")

local middleware_connection = require("../Middlewares/connection")

return function(router)
    router:add_route("/login", "POST", function(req, res)
        if not middleware_connection(req) then
            local code, body, content_type, set_cookie = controller_connection.login(req.body)

            res.status = code
            res.body = body
            res.header["Content-Type"] = content_type

            print(res.body)

            if set_cookie then
                res.header["Set-Cookie"] = set_cookie
            end
        else
            res.body, res.status, res.header["Content-Type"] = "You are already connected",
            status["OK"],
            mime["text"]
        end
    end)
    :add_route("/logout", "POST", function(req, res)
        res.status, res.body, res.header["Content-Type"], res.header["Set-Cookie"] = controller_connection.logout()
    end)
    :add_route("/me", "GET", function(req, res)
        res.status, res.body, res.header["Content-Type"] = controller_connection.me(req.headers["cookie"])
    end)
end