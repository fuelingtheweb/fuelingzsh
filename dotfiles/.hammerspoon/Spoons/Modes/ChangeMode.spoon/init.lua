local ChangeMode = {}
ChangeMode.__index = ChangeMode

ChangeMode.lookup = {
    e = 'toEndOfWord',
    q = 'subword',
    w = 'word',
    a = 'toEndOfLine',
    i = 'toBeginningOfLine',
    v = 'line',
    x = 'character',
}

function ChangeMode.handle(key)
    if key == 'caps_lock' then
        hs.execute("open -g 'hammerspoon://text-disableVim'")
    elseif ChangeMode.lookup[key] then
        hs.execute("open -g 'hammerspoon://change-" .. ChangeMode.lookup[key] .. "'")
    elseif TextManipulation.wrapperKeyLookup[key] then
        keystroke = TextManipulation.wrapperKeyLookup[key]

        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'c', 0)
        hs.eventtap.keyStroke({}, 'i', 0)
        hs.eventtap.keyStroke(keystroke.mods, keystroke.key, 0)
    end
end

hs.urlevent.bind('change-toEndOfWord', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'c', 0)
        hs.eventtap.keyStroke({}, 'e', 0)
    else
        hs.eventtap.keyStroke({'shift', 'alt'}, 'right', 0)
        hs.eventtap.keyStroke({}, 'delete', 0)
    end
end)

hs.urlevent.bind('change-subword', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'c', 0)
        hs.eventtap.keyStroke({}, 'i', 0)
        hs.eventtap.keyStroke({}, 'q', 0)
    end
end)

hs.urlevent.bind('change-word', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'c', 0)
        hs.eventtap.keyStroke({}, 'i', 0)
        hs.eventtap.keyStroke({}, 'w', 0)
    elseif appIs(iterm) and not isAlfredVisible() then
        hs.eventtap.keyStroke({}, 'escape')
        hs.eventtap.keyStrokes('ciw')
    else
        hs.eventtap.keyStroke({'alt'}, 'delete', 0)
    end
end)

hs.urlevent.bind('change-toEndOfLine', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({'shift'}, 'c', 0)
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'right', 0)
        hs.eventtap.keyStroke({}, 'delete', 0)
    end
end)

hs.urlevent.bind('change-toBeginningOfLine', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'left', 0)
        hs.eventtap.keyStroke({}, 'c', 0)
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'left', 0)
        hs.eventtap.keyStroke({}, 'delete', 0)
    end
end)

hs.urlevent.bind('change-line', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'c', 0)
        hs.eventtap.keyStroke({}, 'c', 0)
    elseif appIs(iterm) and not isAlfredVisible() then
        hs.eventtap.keyStroke({}, 'escape')
        hs.eventtap.keyStrokes('cc')
    else
        hs.eventtap.keyStroke({'cmd'}, 'left', 0)
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'right', 0)
        hs.eventtap.keyStroke({}, 'delete', 0)
    end
end)

hs.urlevent.bind('change-character', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({'ctrl', 'alt'}, 'a', 0)
    end

    hs.eventtap.keyStroke({}, 'delete', 0)
end)

return ChangeMode
