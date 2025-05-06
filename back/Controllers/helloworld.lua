return function(req, res, id)
    local body = "Hello World! User " .. id

    res:setHeader("Content-Type", "text/plain")
    res:setHeader("Content-Length", #body)
    res:writeHead(200)

    res:finish(body)
end