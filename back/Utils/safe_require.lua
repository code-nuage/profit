return function(module, err)
    local success, result = pcall(require, module)

    if success then
        return result
    end
    error(err or ("Error importing " .. module))
end