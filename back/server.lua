-- ⠀⠀⠀⣀⡀⠀⢀⠀⠀⠀
-- ⠀⣀⠚⠀⠁⠈⠀⠹⣄⠀
-- ⠸⣀⡀⠀⠀⠀⠀⢀⡸⠃
-- ⠀⠀⠳⠴⠒⠶⠞⠁⠀⠀
--  code-nuage

local http = require("http")
local json = require("json")  -- Luvit a un module JSON intégré

local root = require("./Utils/root")
local safe_require = require("./Utils/safe_require")

local config = safe_require("./config", "\n\27[31;1m--+     ERROR     +--\nHey! It looks like there is no config file in here!\nClone 'config.sample.lua' to 'config.lua' and you should be good to go.\n--+               +--\27[0m")
local routes_user = require("./Routes/user")
local routes_connection = require("./Routes/connection")
local routes_cart = require("./Routes/cart")
local routes_customs = require("./Routes/customs")
local routes_products = require("./Routes/products")

_G.moreutils = require("./Utils/more-utils")

local router = root.new_router()
:set_not_found(require("./Controllers/notfound"))

routes_user(router)
routes_connection(router)
routes_cart(router)
routes_customs(router)
routes_products(router)

router:start(config.server.ip, config.server.port)