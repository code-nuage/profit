local goodbwhy = require("../Utils/goo-db-why")

local model = {}

function model.create(data)
    data.created_at = require("../Utils/time")()
    data.updated_at = data.created_at

    return goodbwhy.dir.select("Products"):insert(data)
end

function model.get_by_id(id)
    return goodbwhy.dir.select("Product"):where_id(id):get()
end

function model.delete_by_id(id)
    return goodbwhy.dir.select("Product"):where_id(id):delete()
end

return model