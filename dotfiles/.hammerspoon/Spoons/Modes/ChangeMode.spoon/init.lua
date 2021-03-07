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

        fastKeyStroke('escape')
        fastKeyStroke('c')
        fastKeyStroke('i')
        fastKeyStroke(keystroke.mods, keystroke.key)
    end
end

hs.urlevent.bind('change-toEndOfWord', function()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('c')
        fastKeyStroke('e')
    else
        fastKeyStroke({'shift', 'alt'}, 'right')
        fastKeyStroke('delete')
    end
end)

hs.urlevent.bind('change-subword', function()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('c')
        fastKeyStroke('i')
        fastKeyStroke('q')
    end
end)

hs.urlevent.bind('change-word', function()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('c')
        fastKeyStroke('i')
        fastKeyStroke('w')
    elseif appIs(iterm) and not isAlfredVisible() then
        fastKeyStroke('escape')
        insertText('ciw')
    else
        fastKeyStroke({'alt'}, 'delete')
    end
end)

hs.urlevent.bind('change-toEndOfLine', function()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke({'shift'}, 'c')
    else
        fastKeyStroke({'shift', 'cmd'}, 'right')
        fastKeyStroke('delete')
    end
end)

hs.urlevent.bind('change-toBeginningOfLine', function()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke({'shift', 'cmd'}, 'left')
        fastKeyStroke('c')
    else
        fastKeyStroke({'shift', 'cmd'}, 'left')
        fastKeyStroke('delete')
    end
end)

hs.urlevent.bind('change-line', function()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('c')
        fastKeyStroke('c')
    elseif appIs(iterm) and not isAlfredVisible() then
        fastKeyStroke('escape')
        insertText('cc')
    else
        fastKeyStroke({'cmd'}, 'left')
        fastKeyStroke({'shift', 'cmd'}, 'right')
        fastKeyStroke('delete')
    end
end)

hs.urlevent.bind('change-character', function()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke({'ctrl', 'alt'}, 'a')
    end

    fastKeyStroke('delete')
end)

return ChangeMode
