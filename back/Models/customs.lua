local goodbwhy = require("../Utils/goo-db-why")

local model = {}

function model.create(data)
    data.created_at = require("../Utils/time")()
    data.updated_at = data.created_at

    return goodbwhy.dir.select("Customs"):insert(data)
end

function model.get_by_id(id)
    return goodbwhy.dir.select("Customs"):where_id(id):get()
end

function model.get_all()
    return goodbwhy.dir.select("Customs"):get()
end

function model.get_id_by_name(name)
    return goodbwhy.dir.select("Customs"):where("name", name):get_ids()
end

model.types = {}

function model.types.create(data)
    return goodbwhy.dir.select("CustomsTypes"):insert(data)
end

function model.types.get_by_id(id)
    return goodbwhy.dir.select("CustomsTypes"):where_id(id):get()
end

function model.types.get_all()
    return goodbwhy.dir.select("CustomsTypes"):get()
end

function model.types.get_id_by_name(name)
    return goodbwhy.dir.select("CustomsTypes"):where("name", name):get_ids()
end

return model
