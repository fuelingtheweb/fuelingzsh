local DestroyMode = {}
DestroyMode.__index = DestroyMode

DestroyMode.lookup = {
    e = 'toEndOfWord',
    w = 'word',
    a = 'toEndOfLine',
    i = 'toBeginningOfLine',
    v = 'line',
    x = 'character',
}

function DestroyMode.handle(key)
    if key == 'spacebar' then
        hs.eventtap.keyStroke({}, 'delete', 0)
    elseif DestroyMode.lookup[key] then
        hs.execute("open -g 'hammerspoon://destroy-" .. DestroyMode.lookup[key] .. "'")
    elseif TextManipulation.wrapperKeyLookup[key] then
        keystroke = TextManipulation.wrapperKeyLookup[key]

        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'd', 0)
        hs.eventtap.keyStroke({}, 'i', 0)
        hs.eventtap.keyStroke(keystroke.mods, keystroke.key, 0)
    end
end

hs.urlevent.bind('destroy-toEndOfWord', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'd', 0)
        hs.eventtap.keyStroke({}, 'e', 0)
    else
        hs.eventtap.keyStroke({'shift', 'alt'}, 'right', 0)
        hs.eventtap.keyStroke({}, 'delete', 0)
    end
end)

hs.urlevent.bind('destroy-word', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'd', 0)
        hs.eventtap.keyStroke({}, 'i', 0)
        hs.eventtap.keyStroke({}, 'w', 0)
    elseif appIs(iterm) then
        hs.eventtap.keyStroke({'ctrl'}, 'w', 0)
    else
        hs.eventtap.keyStroke({'alt'}, 'delete', 0)
    end
end)

hs.urlevent.bind('destroy-toEndOfLine', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({'shift'}, 'd', 0)
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'right', 0)
        hs.eventtap.keyStroke({}, 'delete', 0)
    end
end)

hs.urlevent.bind('destroy-toBeginningOfLine', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'left', 0)
        hs.eventtap.keyStroke({}, 'd', 0)
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'left', 0)
        hs.eventtap.keyStroke({}, 'delete', 0)
    end
end)

hs.urlevent.bind('destroy-line', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'd', 0)
        hs.eventtap.keyStroke({}, 'd', 0)
    else
        hs.eventtap.keyStroke({'cmd'}, 'left', 0)
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'right', 0)
        hs.eventtap.keyStroke({}, 'delete', 0)
    end
end)

hs.urlevent.bind('destroy-character', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'x', 0)
    else
        hs.eventtap.keyStroke({}, 'delete', 0)
    end
end)

return DestroyMode
