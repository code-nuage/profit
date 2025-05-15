local goodbwhy = require("../Utils/goo-db-why")
local sha256 = require("../Utils/sha256")

goodbwhy.select_database("../database")

local function get_time()
    return os.date("%Y-%m-%d %H:%M:%S")
end

local model = {}

function model.create(data)
    data.password = sha256(data.password)
    data.created_at = get_time()
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

return model
