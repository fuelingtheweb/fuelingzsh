local AppShortcut = {}
AppShortcut.__index = AppShortcut

function AppShortcut.handle(key)
    hs.execute("open -g 'hammerspoon://shortcut-trigger?key=" .. key:upper() .. "'")
end

return AppShortcut
