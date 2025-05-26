local controller_cart = require("../Controllers/cart")

return function(router)
    router:add_route("/cart", "POST", function(req, res)                       -- I just love chained method don't mind
        res.status, res.body, res.header["Content-Type"] = controller_cart.create(req.body)
    end)
end