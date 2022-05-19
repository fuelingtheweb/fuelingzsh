local Table = {}
Table.__index = Table

function Table.has(table, needle)
    for k, v in ipairs(table) do
        if v == needle then
            return true
        end
    end

    return false
end

function Table.count(table)
    if not table then return 0 end

    local count = 0

    Table.each(table, function()
        count = count + 1
    end)

    return count
end

function Table.each(table, callback)
    for key, value in pairs(table) do
        callback(value, key)
    end
end

return Table
