local controller_customs = require("../Controllers/customs")

return function(router)
    router:add_route("/custom/:value", "GET", function(req, res)
        res.status, res.body, res.header["Content-Type"] = controller_customs.read_by_id(tonumber(req.params.value))
    end)
    :add_route("/custom", "POST", function(req, res)
        res.status, res.body, res.header["Content-Type"] = controller_customs.create(req.body)
    end)
    :add_route("/customtype", "POST", function(req, res)
        res.status, res.body, res.header["Content-Type"] = controller_customs.types.create(req.body)
    end)
    :add_route("/customtype/:value", "GET", function(req, res)
        if req.params.value:match("^%d+$") then                                -- Check if the params is an ID
            res.status, res.body, res.header["Content-Type"] = controller_customs.types.read_by_id(tonumber(req.params.value))
        else                                                                   -- Else the value should be a name
            res.status, res.body, res.header["Content-Type"] = controller_customs.types.read_id_by_name(req.params.value)
        end
    end)
    :add_route("/customtypes", "GET", function(req, res)
        res.status, res.body, res.header["Content-Type"] = controller_customs.types.read_all()
    end)
end