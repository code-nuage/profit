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

moreutils.table.dump = function(list, indent, seen)
    indent = indent or 0
    seen = seen or {}
    local indent_str = string.rep("  ", indent)

    if type(list) == "table" then
        if seen[list] then
            return '"<circular reference>"'
        end
        seen[list] = true

        local s = "{\n"
        for k, v in pairs(list) do
            local key = type(k) == "string" and string.format('["%s"]', k) or string.format("[%s]", tostring(k))
            s = s .. indent_str .. "  " .. key .. " = " .. moreutils.table.dump(v, indent + 1, seen) .. ",\n"
        end
        return s .. indent_str .. "}"
    else
        return tostring(list)
    end
end

return moreutils