local goodbwhy = require("../Utils/goo-db-why")
local sha256 = require("../Utils/sha256")

goodbwhy.select_database("./Database")

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

return model
