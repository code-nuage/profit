local controller_products = require("../Controllers/products")

return function(router)
    router:add_route("/product", "POST", function(req, res)
        res.status, res.body, res.header["Content-Type"] = controller_products.create(req.body)
    end)
end