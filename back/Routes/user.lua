local controller_user = require("../Controllers/user")

return function(router)
    router:add_route("/user", "POST", function(req, res)                       -- I just love chained method don't mind
        local code, body, mime = controller_user.create(req.body)

        res:writeHead(code)
        res:setHeader("Content-Type", mime)
        res:setHeader("Content-Length", #body)

        res:finish(body)
    end):add_route("/user/:value", "GET", function(req, res)
        local code, body, mime

        if req.params.value:match("^%d+$") then                                -- Check if the params is an ID
            code, body, mime = controller_user.read_by_id(tonumber(req.params.value))
        else
            code, body, mime = controller_user.read_by_email(req.params.value)
        end

        res:writeHead(code)
        res:setHeader("Content-Type", mime)
        res:setHeader("Content-Length", #body)

        res:finish(body)
    end):add_route("/users", "GET", function(req, res)
        local code, body, mime = controller_user.read_all()

        res:writeHead(code)
        res:setHeader("Content-Type", mime)
        res:setHeader("Content-Length", #body)

        res:finish(body)
    end):add_route("/user/:email", "DELETE", function(req, res)
        local code, body, mime = controller_user.delete_by_email(req.params.email)

        res:writeHead(code)
        res:setHeader("Content-Type", mime)
        res:setHeader("Content-Length", #body)

        res:finish(body)
    end)
end