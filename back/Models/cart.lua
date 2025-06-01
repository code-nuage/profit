local goodbwhy = require("../Utils/goo-db-why")

local model = {}

function model.create(data)
    data.products = {}
    data.status_id = 1
    data.created_at = require("../Utils/time")()
    data.updated_at = data.created_at

    return goodbwhy.dir.select("Cart"):insert(data)
end

function model.get_by_email(user_email)
    return goodbwhy.dir.select("Cart"):where("user_email", user_email):get()
end

function model.add_product(user_email, products)
    return goodbwhy.dr.select("Cart"):where("user_email", user_email):update({products = products})
end

model.status = {}

function model.status.create(data)
    return goodbwhy.dir.select("CartStatus"):insert(data)
end

function model.status.get_by_id(id)
    return goodbwhy.dir.select("CartStatus"):where_id(id):get()
end

function model.status.delete_by_id(id)
    return goodbwhy.dir.select("CartStatus"):where_id(id):delete()
end

return model