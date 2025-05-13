local fs = require("coro-fs")
local json = require("json")

local goodbwhy = {}
goodbwhy.database = nil
goodbwhy.dir = {}
goodbwhy.dir.__index = goodbwhy.dir

--+ UTILS +--
local function dir_exists(path)
    local stat = fs.stat(path)
    return stat and stat.type == "directory"
end

local function assert_dir_exists(path)
    if not dir_exists(path) then
        fs.mkdir(path)
    end
end

local function file_exists(path)
    local stat = fs.stat(path)
    return stat and stat.type == "file"
end

local function assert_file_exists(path)
    if not file_exists(path) then
        fs.writeFile(path, "") -- must write something
    end
end

local function read_data(path)
    if file_exists(path) then
        local json_data = fs.readFile(path)
        if json_data then
            return json.decode(json_data)
        end
    end
    return nil
end

local function write_file(path, json_data)
    local ok, err = fs.writeFile(path, json_data)
    if not ok then
        print("Error writing file:", err)
        return false
    end
    return true
end

local function delete_file(path)
    local ok, err = fs.rmrf(path)
    if not ok then
        print("Error deleting file:", err)
        return false
    end
    return true
end

--+     GOO-DB-WHY     +--
function goodbwhy.select_database(path)
    assert_dir_exists(path)
    goodbwhy.database = path
end

function goodbwhy.dir.select(path)
    local full_path = goodbwhy.database .. "/" .. path
    assert_dir_exists(full_path)

    local instance = setmetatable({}, goodbwhy.dir)
    instance.path = full_path
    instance.ids = nil

    return instance
end

function goodbwhy.dir:get_file_by_id(id)
    return self.path .. "/" .. id .. ".json"
end

function goodbwhy.dir:get_all_ids()
    local get_next_file = fs.scandir(self.path)
    local ids = {}

    while true do
        local entry = get_next_file()
        if not entry then break end
        if not entry.name:match("^%.") and entry.name:match("^(%d+)%.json$") then
            local id = tonumber(entry.name:match("^(%d+)"))
            if id then
                table.insert(ids, id)
            end
        end
    end

    table.sort(ids)
    return ids
end

--+ FILTERING +--
function goodbwhy.dir:where(key, value)
    assert(type(key) == "string", "Key must be a string.")
    self.ids = self.ids or self:get_all_ids()

    local filtered_ids = {}
    for _, id in ipairs(self.ids) do
        local data = read_data(self:get_file_by_id(id))
        if data and data[key] == value then
            table.insert(filtered_ids, id)
        end
    end

    self.ids = filtered_ids
    return self
end

function goodbwhy.dir:where_id(id)
    assert(type(id) == "number", "ID must be a number.")
    self.ids = {id}
    return self
end

--+ CRUD COMPLETE +--
function goodbwhy.dir:insert(data, id)
    assert(type(data) == "table", "Data must be a table.")

    local next_id = id
    if not next_id then
        local ids = self:get_all_ids()
        local last_id = ids[#ids]
        next_id = last_id and (last_id + 1) or 1
    end

    local json_data = json.encode(data)
    if not json_data then
        return false
    end

    if write_file(self:get_file_by_id(next_id), json_data) then
        return data
    end

    return false
end

function goodbwhy.dir:get()
    local ids = self.ids or self:get_all_ids()
    if #ids == 0 then
        return nil
    end

    local datas = {}
    for _, id in ipairs(ids) do
        local data = read_data(self:get_file_by_id(id))
        if data then
            table.insert(datas, data)
        end
    end

    if #datas == 0 then
        return nil
    elseif #datas == 1 then
        return datas[1]
    end

    return datas
end

function goodbwhy.dir:get_ids()
    local ids = self.ids or self:get_all_ids()

    return ids
end

function goodbwhy.dir:update(data)
    assert(type(data) == "table", "Data must be a table.")
    assert(self.ids and #self.ids == 1, "You must use where_id() to target a specific ID for update.")

    local updated = {}
    for _, id in ipairs(self.ids) do
        local file_path = self:get_file_by_id(id)
        local existing = read_data(file_path)
        if existing then
            for k, v in pairs(data) do
                existing[k] = v
            end
            local json_data = json.encode(existing)
            if write_file(file_path, json_data) then
                table.insert(updated, existing)
            end
        end
    end

    return #updated > 0 and updated or nil
end

function goodbwhy.dir:delete()
    local ids = self.ids or self:get_all_ids()
    if #ids == 0 then
        return false
    end

    for _, id in ipairs(ids) do
        local file_path = self:get_file_by_id(id)
        if file_exists(file_path) then
            delete_file(file_path)
        else
            return false
        end
    end

    return true
end

return goodbwhy
