local controller_user = require("../Controllers/user")

return function(router)
    router:add_route("/user", "POST", function(req, res)                       -- I just love chained method don't mind
        res.status, res.body, res.header["Content-Type"] = controller_user.create(req.body)
    end)
    :add_route("/user/:value", "GET", function(req, res)
        if req.params.value:match("^%d+$") then                                -- Check if the params is an ID
            res.status, res.body, res.header["Content-Type"] = controller_user.read_by_id(tonumber(req.params.value))
        else
            res.status, res.body, res.header["Content-Type"] = controller_user.read_by_email(req.params.value)
        end
        router:set_cors_headers()
    end)
    :add_route("/users", "GET", function(req, res)
        res.status, res.body, res.header["Content-Type"] = controller_user.read_all()
    end)
    :add_route("/user/:email", "DELETE", function(req, res)
        res.status, res.body, res.header["Content-Type"] = controller_user.delete_by_email(req.params.email)
    end)
    :add_route("/user/:email", "DELETE", function(req, res)
        res.status, res.body, res.header["Content-Type"] = controller_user.delete_by_email(req.params.email)
    end)
end