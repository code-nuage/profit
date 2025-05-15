
-- Root, a simple OOP turned Luvit router
--            @code-nuage

local http = require("http")
local url = require("url")
local querystring = require("querystring")

local root = {}
root.__index = root

function root.new_router()
    local i = setmetatable({}, root)

    i.routes = {}

    return i
end

function root:add_route(route, method, controller)
    local keys = {}

    local pattern = route:gsub("(:%w+)", function(key)
        table.insert(keys, key:sub(2))
        return "([^/]+)"
    end)

    pattern = "^" .. pattern .. "$"

    table.insert(self.routes, {
        pattern = pattern,
        method = method,
        keys = keys,
        controller = controller
    })

    return self
end

function root:set_not_found(controller)
    self.not_found_controller = controller
    return self
end

function root:handle_request(req, res)
    local parsed = url.parse(req.url)
    local path = querystring.urldecode(parsed.pathname)                        -- Query string to handle special chars in URL

    self:reassign_headers(req)

    print("Request: " .. "URI: " .. req.url ..
    " Method: " .. req.method ..
    "\nAgent@host: " .. req.headers["user-agent"] .. "@" .. req.headers["host"])

    for _, route in ipairs(self.routes) do
        local matches = {path:match(route.pattern)}
        if #matches > 0 then
            if route.method == req.method then
                req.params = {}
                for i, key in ipairs(route.keys) do
                    req.params[key] = matches[i]
                end
                return coroutine.wrap(function()
                    route.controller(req, res)
                end)()
            end
        end
    end

    if self.not_found_controller and type(self.not_found_controller) == "function" then
        self:route_not_found(req, res)
    else
        res:writeHead(404, {["Content-Type"] = "text/plain"})
        res:finish("Error 404 - Route not found")
    end
end

function root:route_not_found(req, res)
    return coroutine.wrap(function()
        self.not_found_controller(req, res)
    end)()
end

function root:reassign_headers(req)
    local headers = {}
    for _, header in ipairs(req.headers) do
        headers[header[1]] = header[2]
    end
    req.headers = headers
end

function root:start(ip, port)
    http.createServer(function (req, res)
        local chunks = {}

        req:on("data", function(chunk)
            table.insert(chunks, chunk)
        end)

        req:on("end", function()
            local body = table.concat(chunks)

            req.body = body

            self:handle_request(req, res)
        end)
    end):listen(port, ip)
end

return root
