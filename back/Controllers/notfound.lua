return function(req, res)
    local body = "404 - Route not found"

    res:setHeader("Content-Type", "text/plain")
    res:setHeader("Content-Length", #body)
    res:writeHead(404)

    res:finish(body)
end