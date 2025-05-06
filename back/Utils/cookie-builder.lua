return function(name, value, options)
    assert(type(name) == "string", "Cookie name must be a string")
    assert(type(value) == "string", "Cookie value must be a string")
    assert(type(options) == "table", "Cookie options must be a table")

    local cookie = name .. "=" .. value .. "; "

    for option_name, option_value in pairs(options) do
        if type(option_name) == "number" then                                  -- Checks if the value is simply stored in an indexed key (alone in the table)
            cookie = cookie .. option_value .. "; "
        else
            cookie = cookie .. option_name .. "=" .. option_value .. "; "
        end
    end

    return cookie
end