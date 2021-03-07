local SelectInsideMode = {}
SelectInsideMode.__index = SelectInsideMode

SelectInsideMode.lookup = {
    q = 'subword',
    w = 'word',
    v = 'line',
    x = 'character',
}

function SelectInsideMode.handle(key)
    if SelectInsideMode.lookup[key] then
        hs.execute("open -g 'hammerspoon://select-inside-" .. SelectInsideMode.lookup[key] .. "'")
    elseif TextManipulation.wrapperKeyLookup[key] then
        keystroke = TextManipulation.wrapperKeyLookup[key]

        fastKeyStroke('escape')
        fastKeyStroke('v')
        fastKeyStroke('i')
        fastKeyStroke(keystroke.mods, keystroke.key)
    end
end

hs.urlevent.bind('select-inside-subword', function()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('v')
        fastKeyStroke('i')
        fastKeyStroke('q')
    end
end)

hs.urlevent.bind('select-inside-word', function()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('v')
        fastKeyStroke('i')
        fastKeyStroke('w')
    else
        fastKeyStroke({'shift', 'alt'}, 'left')
    end
end)

hs.urlevent.bind('select-inside-line', function()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke({'shift'}, 'v')
    else
        fastKeyStroke({'cmd'}, 'left')
        fastKeyStroke({'shift', 'cmd'}, 'right')
    end
end)

hs.urlevent.bind('select-inside-character', function()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('v')
    else
        fastKeyStroke({'shift'}, 'left')
    end
end)

return SelectInsideMode
