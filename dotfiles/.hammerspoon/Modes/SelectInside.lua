local SelectInside = {}
SelectInside.__index = SelectInside

SelectInside.lookup = {
    tab = nil,
    q = 'subword',
    w = 'word',
    e = nil,
    r = nil,
    t = 'withWrapperKey',
    caps_lock = nil,
    a = nil,
    s = 'withWrapperKey',
    d = 'withWrapperKey',
    f = 'withWrapperKey',
    g = nil,
    left_shift = nil,
    z = 'withWrapperKey',
    x = 'character',
    c = 'withWrapperKey',
    v = 'line',
    b = 'withWrapperKey',
    spacebar = nil,
}

function SelectInside.withWrapperKey(key)
    keystroke = TextManipulation.wrapperKeyLookup[key]

    fastKeyStroke('escape')
    fastKeyStroke('v')
    fastKeyStroke('i')
    fastKeyStroke(keystroke.mods, keystroke.key)
end

function SelectInside.subword()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('v')
        fastKeyStroke('i')
        fastKeyStroke('q')
    end
end

function SelectInside.word()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('v')
        fastKeyStroke('i')
        fastKeyStroke('w')
    else
        fastKeyStroke({'shift', 'alt'}, 'left')
    end
end

function SelectInside.line()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke({'shift'}, 'v')
    else
        fastKeyStroke({'cmd'}, 'left')
        fastKeyStroke({'shift', 'cmd'}, 'right')
    end
end

function SelectInside.character()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('v')
    else
        fastKeyStroke({'shift'}, 'left')
    end
end

return SelectInside
