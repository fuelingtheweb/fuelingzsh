local AppMode = {}
AppMode.__index = AppMode

function AppMode.handle(key)
    hs.execute("open -g 'hammerspoon://shortcut-trigger?key=" .. key:upper() .. "'")
end

return AppMode
