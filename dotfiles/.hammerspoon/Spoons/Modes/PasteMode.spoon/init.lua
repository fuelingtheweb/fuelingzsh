local PasteMode = {}
PasteMode.__index = PasteMode

PasteMode.lookup = {
    e = 'toEndOfWord',
    q = 'subword',
    w = 'word',
    a = 'toEndOfLine',
    i = 'toBeginningOfLine',
    v = 'line',
    x = 'character',
}

function PasteMode.handle(key)
    if key == 'caps_lock' then
        triggerAlfredWorkflow('paste:strip', 'com.fuelingtheweb.commands')
    elseif PasteMode.lookup[key] then
        hs.execute("open -g 'hammerspoon://paste-" .. PasteMode.lookup[key] .. "'")
    elseif TextManipulation.wrapperKeyLookup[key] then
        keystroke = TextManipulation.wrapperKeyLookup[key]

        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'v', 0)
        hs.eventtap.keyStroke({}, 'i', 0)
        hs.eventtap.keyStroke(keystroke.mods, keystroke.key, 0)
        hs.eventtap.keyStroke({}, 'p', 0)
    end
end

hs.urlevent.bind('paste-toEndOfWord', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'v', 0)
        hs.eventtap.keyStroke({}, 'e', 0)
        hs.eventtap.keyStroke({}, 'p', 0)
    else
        hs.eventtap.keyStroke({'shift', 'alt'}, 'right', 0)
        hs.eventtap.keyStroke({'cmd'}, 'v', 0)
    end
end)

hs.urlevent.bind('paste-subword', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'v', 0)
        hs.eventtap.keyStroke({}, 'i', 0)
        hs.eventtap.keyStroke({}, 'q', 0)
        hs.eventtap.keyStroke({}, 'p', 0)
    end
end)

hs.urlevent.bind('paste-word', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'v', 0)
        hs.eventtap.keyStroke({}, 'i', 0)
        hs.eventtap.keyStroke({}, 'w', 0)
        hs.eventtap.keyStroke({}, 'p', 0)
    else
        hs.eventtap.keyStroke({'shift', 'alt'}, 'left', 0)
        hs.eventtap.keyStroke({'cmd'}, 'v', 0)
    end
end)

hs.urlevent.bind('paste-toEndOfLine', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'v', 0)
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'right', 0)
        hs.eventtap.keyStroke({}, 'p', 0)
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'right', 0)
        hs.eventtap.keyStroke({'cmd'}, 'v', 0)
    end
end)

hs.urlevent.bind('paste-toBeginningOfLine', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'left', 0)
        hs.eventtap.keyStroke({}, 'p', 0)
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'left', 0)
        hs.eventtap.keyStroke({'cmd'}, 'v', 0)
    end
end)

hs.urlevent.bind('paste-line', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({'shift'}, 'v', 0)
        hs.eventtap.keyStroke({}, 'p', 0)
    else
        hs.eventtap.keyStroke({'cmd'}, 'left', 0)
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'right', 0)
        hs.eventtap.keyStroke({'cmd'}, 'v', 0)
    end
end)

hs.urlevent.bind('paste-character', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'v', 0)
        hs.eventtap.keyStroke({}, 'p', 0)
    else
        hs.eventtap.keyStroke({'shift'}, 'left', 0)
        hs.eventtap.keyStroke({'cmd'}, 'v', 0)
    end
end)

return PasteMode
