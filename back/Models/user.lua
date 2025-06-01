local goodbwhy = require("../Utils/goo-db-why")
local sha256 = require("../Utils/sha256")

goodbwhy.select_database("../database")

local model = {}

function model.create(data)
    data.password = sha256(data.password)
    data.created_at = require("../Utils/time")()
    data.updated_at = data.created_at

    return goodbwhy.dir.select("Users"):insert(data)
end

function model.get_by_id(id)
    return goodbwhy.dir.select("Users"):where_id(id):get()
end

function model.get_by_email(email)
    return goodbwhy.dir.select("Users"):where("email", email):get()
end

function model.get_all()
    return goodbwhy.dir.select("Users"):get()
end

function model.update_by_email(email, data)
    if data.password then
        data.password = sha256(data.password)
    end
    data.updated_at = require("../Utils/time")()

    return goodbwhy.dir.select("Users"):where("email", email):update(data)
end

function model.delete_by_email(email)
    return goodbwhy.dir.select("Users"):where("email", email):delete()
end

return model
