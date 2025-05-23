-- ⠀⠀⠀⣀⡀⠀⢀⠀⠀⠀
-- ⠀⣀⠚⠀⠁⠈⠀⠹⣄⠀
-- ⠸⣀⡀⠀⠀⠀⠀⢀⡸⠃
-- ⠀⠀⠳⠴⠒⠶⠞⠁⠀⠀
--  code-nuage

local http = require("http")
local json = require("json")  -- Luvit a un module JSON intégré

local root = require("./Utils/root")

local config = require("./config")
local user_routes = require("./Routes/user")
local connection_routes = require("./Routes/connection")

_G.moreutils = require("./Utils/more-utils")

local router = root.new_router()
:set_not_found(require("./Controllers/notfound"))

user_routes(router)
connection_routes(router)

router:start(config.server.ip, config.server.port)