local controller_user = require("../Controllers/user")

return function(router)
    router:add_route("/user", "POST", function(req, res)
        local code, body, mime = controller_user.create(req.body)

        res:writeHead(code)
        res:setHeader("Content-Type", mime)
        res:setHeader("Content-Length", #body)

        res:finish(body)
    end):add_route("/user/:value", "GET", function(req, res)
        local code, body, mime

        if req.params.value:match("^%d+$") then
            code, body, mime = controller_user.read_by_id(tonumber(req.params.value))
        else
            code, body, mime = controller_user.read_by_email(req.params.value)
        end

        res:writeHead(code)
        res:setHeader("Content-Type", mime)
        res:setHeader("Content-Length", #body)

        res:finish(body)
    end):add_route("/users/", "GET", function(req, res)
        local code, body, mime = controller_user.read_all()

        res:writeHead(code)
        res:setHeader("Content-Type", mime)
        res:setHeader("Content-Length", #body)

        res:finish(body)
    end)
end