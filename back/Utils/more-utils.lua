local moreutils = {}

moreutils.table = {}

moreutils.table.has = function(list, key)
    return list[key] ~= nil
end

moreutils.table.contains = function(list, value)
    for _, v in pairs(list) do
        if v == value then
            return true
        end
    end
    return false
end

moreutils.table.dump = function(list, indent)
    indent = indent or 0
    local indent_str = string.rep("  ", indent)

    if type(list) == "table" then
        local s = "{\n"
        for k, v in pairs(list) do
            local key
            if type(k) == "string" then
                key = string.format('["%s"]', k)
            else
                key = string.format("[%s]", tostring(k))
            end
            s = s .. indent_str .. "  " .. key .. " = " .. moreutils.table.dump(v, indent + 1) .. ",\n"
        end
        return s .. indent_str .. "}"
    else
        return tostring(list)
    end
end

return moreutils