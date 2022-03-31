local TablePlus = {}
TablePlus.__index = TablePlus

function TablePlus.open(url)
    hs.execute('open "' .. url .. '"')
end

return TablePlus
