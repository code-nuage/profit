local controller_user = require("../Controllers/user")

return function(router)
    router:add_route("/user", function(req, res)
        if req.method == "POST" then
            local code, body, mime = controller_user.create(req.body)

            res:writeHead(code)
            res:setHeader("Content-Type", mime)
            res:setHeader("Content-Length", #body)

            res:finish(body)
        end
    end)
end