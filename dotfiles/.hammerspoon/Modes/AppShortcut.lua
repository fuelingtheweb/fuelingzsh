local AppShortcut = {}
AppShortcut.__index = AppShortcut

function AppShortcut.handle(key)
    Shortcuts:handle(key:upper())
end

return AppShortcut
