local json = require("json")

local mime = require("../Utils/mime")
local status = require("../Utils/status")

local model_products = require("../Models/products")

local controller = {}

function controller.create(json_data)
    local data = json.decode(json_data)

    if data then
        local returned_data = model_products.create(data)
        return status["Created"],
        json.encode(returned_data),
        mime["json"]
    end

    return status["Internal Server Error"],
    "Internal Server Error",
    mime["text"]
end

return controller