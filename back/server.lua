-- ⠀⠀⠀⣀⡀⠀⢀⠀⠀⠀
-- ⠀⣀⠚⠀⠁⠈⠀⠹⣄⠀
-- ⠸⣀⡀⠀⠀⠀⠀⢀⡸⠃
-- ⠀⠀⠳⠴⠒⠶⠞⠁⠀⠀
--  code-nuage

local http = require("http")
local json = require("json")  -- Luvit a un module JSON intégré

local root = require("./Utils/root")

local config = require("./config")
local routes_user = require("./Routes/user")
local routes_connection = require("./Routes/connection")
local routes_cart = require("./Routes/cart")

_G.moreutils = require("./Utils/more-utils")

local router = root.new_router()
:set_not_found(require("./Controllers/notfound"))

routes_user(router)
routes_connection(router)
routes_cart(router)

router:start(config.server.ip, config.server.port)