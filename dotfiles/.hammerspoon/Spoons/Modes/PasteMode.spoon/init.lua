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

        fastKeyStroke('escape')
        fastKeyStroke('v')
        fastKeyStroke('i')
        fastKeyStroke(keystroke.mods, keystroke.key)
        fastKeyStroke('p')
    end
end

hs.urlevent.bind('paste-toEndOfWord', function()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('v')
        fastKeyStroke('e')
        fastKeyStroke('p')
    else
        fastKeyStroke({'shift', 'alt'}, 'right')
        fastKeyStroke({'cmd'}, 'v')
    end
end)

hs.urlevent.bind('paste-subword', function()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('v')
        fastKeyStroke('i')
        fastKeyStroke('q')
        fastKeyStroke('p')
    end
end)

hs.urlevent.bind('paste-word', function()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('v')
        fastKeyStroke('i')
        fastKeyStroke('w')
        fastKeyStroke('p')
    else
        fastKeyStroke({'shift', 'alt'}, 'left')
        fastKeyStroke({'cmd'}, 'v')
    end
end)

hs.urlevent.bind('paste-toEndOfLine', function()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('v')
        fastKeyStroke({'shift', 'cmd'}, 'right')
        fastKeyStroke('p')
    else
        fastKeyStroke({'shift', 'cmd'}, 'right')
        fastKeyStroke({'cmd'}, 'v')
    end
end)

hs.urlevent.bind('paste-toBeginningOfLine', function()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke({'shift', 'cmd'}, 'left')
        fastKeyStroke('p')
    else
        fastKeyStroke({'shift', 'cmd'}, 'left')
        fastKeyStroke({'cmd'}, 'v')
    end
end)

hs.urlevent.bind('paste-line', function()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke({'shift'}, 'v')
        fastKeyStroke('p')
    else
        fastKeyStroke({'cmd'}, 'left')
        fastKeyStroke({'shift', 'cmd'}, 'right')
        fastKeyStroke({'cmd'}, 'v')
    end
end)

hs.urlevent.bind('paste-character', function()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('v')
        fastKeyStroke('p')
    else
        fastKeyStroke({'shift'}, 'left')
        fastKeyStroke({'cmd'}, 'v')
    end
end)

return PasteMode
