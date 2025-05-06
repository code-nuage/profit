local http = require("http")

local config = require("./config")

local root = require("./Utils/root")

local controller_helloworld = require("./Controllers/helloworld")

local router = root.new_router()
:set_not_found(require("./Controllers/notfound"))
:add_route("/helloworld/:id", function(req, res)
    controller_helloworld(req, res, req.params.id)
end)

http.createServer(function (req, res)
    router:handle_request(req, res)
end):listen(config.server.port, config.server.ip)