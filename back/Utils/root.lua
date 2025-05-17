
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
    local path = querystring.urldecode(parsed.pathname)

    self:reassign_req_headers(req)

    self:display_request(req)

    self:preflight(req, res)

    for _, route in ipairs(self.routes) do
        local matches = {path:match(route.pattern)}
        if #matches > 0 and route.method == req.method then
            req.params = {}
            for i, key in ipairs(route.keys) do
                req.params[key] = matches[i]
            end
            return coroutine.wrap(function()
                res.header = {}
                route.controller(req, res)
                if res.status then
                    res:writeHead(res.status)
                else
                    print("A response should really send a status code")
                end
                if res.header then
                    self:reassign_res_headers(res)
                end
                if res.body then
                    res:finish(res.body)
                else
                    res:finish()
                end
            end)()
        end
    end

    self:route_not_found(req, res)
end

function root:preflight(req, res)
    if req.method == "OPTIONS" then
        res:writeHead(204)
        self:set_cors_headers(req, res)
        print(moreutils.table.dump(res))
        res:finish()
        return
    end
end

function root:route_not_found(req, res)
    if self.not_found_controller then
        return coroutine.wrap(function()
            self.not_found_controller(req, res)
        end)()
    else
        res:writeHead(404, {["Content-Type"] = "text/plain"})
        res:finish("Error 404 - Route not found")
    end
end

function root:display_request(req)
    print("Request: URI: " .. req.url .. " Method: " .. req.method)
    print("Agent@host: " .. (req.headers["user-agent"] or "-") .. "@" .. (req.headers["host"] or "-"))
end

function root:reassign_req_headers(req)
    local headers = {}
    for _, header in ipairs(req.headers) do
        headers[string.lower(header[1])] = header[2]
    end
    req.headers = headers
end

function root:reassign_res_headers(res)
    local headers = {}
    for key, header in pairs(res.header) do                                    -- Can't use res.headers table since writeHead overwrite it
        headers[#headers+1] = {key, header}
    end
    res.headers = headers
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
    print("Server started @ " .. ip .. ":" .. port)
end

function root:set_cors_headers(req, res)
    local origin = req.headers["origin"]

    if origin then
        res:setHeader("Access-Control-Allow-Origin", origin)
        res:setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization")
        res:setHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS")
        res:setHeader("Access-Control-Allow-Credentials", true)
    end
end

return root
