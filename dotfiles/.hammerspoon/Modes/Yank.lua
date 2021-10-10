local Yank = {}
Yank.__index = Yank

Yank.lookup = {
    tab = 'untilBackward',
    q = 'subword',
    w = 'word',
    e = 'toEndOfWord',
    r = 'untilForward',
    t = 'withWrapperKey',
    caps_lock = 'all',
    a = 'toEndOfLine',
    s = 'withWrapperKey',
    d = 'withWrapperKey',
    f = 'withWrapperKey',
    g = 'toBeginningOfLine',
    left_shift = 'toTopOfPage',
    z = 'withWrapperKey',
    x = 'character',
    c = 'withWrapperKey',
    v = 'line',
    b = 'withWrapperKey',
    spacebar = nil,
}

function Yank.word()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('y')
        fastKeyStroke('i')
        fastKeyStroke('w')
    else
        fastKeyStroke({'shift', 'alt'}, 'left')
        fastKeyStroke({'cmd'}, 'c')
        fastKeyStroke('right')
    end
end

function Yank.withWrapperKey(key)
    keystroke = TextManipulation.wrapperKeyLookup[key]

    fastKeyStroke('escape')
    fastKeyStroke('y')
    fastKeyStroke('i')
    fastKeyStroke(keystroke.mods, keystroke.key)
end

function Yank.toEndOfWord()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('y')
        fastKeyStroke('e')
    else
        fastKeyStroke({'shift', 'alt'}, 'right')
        fastKeyStroke({'cmd'}, 'c')
        fastKeyStroke('left')
    end
end

function Yank.relativeFilePath()
    if inCodeEditor() then
        fastKeyStroke({'ctrl', 'alt', 'cmd'}, 'y')
    end
end

function Yank.subword()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('y')
        fastKeyStroke('i')
        fastKeyStroke('q')
    end
end

function Yank.toEndOfLine()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('y')
        fastKeyStroke({'shift'}, '4')
    else
        fastKeyStroke({'shift', 'cmd'}, 'right')
        fastKeyStroke({'cmd'}, 'c')
        fastKeyStroke('left')
    end
end

function Yank.toBeginningOfLine()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('right')
        fastKeyStroke({'shift', 'cmd'}, 'left')
        fastKeyStroke('y')
    else
        fastKeyStroke({'shift', 'cmd'}, 'left')
        fastKeyStroke({'cmd'}, 'c')
        fastKeyStroke('right')
    end
end

function Yank.line()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('y')
        fastKeyStroke('y')
    else
        fastKeyStroke({'cmd'}, 'left')
        fastKeyStroke({'shift', 'cmd'}, 'right')
        fastKeyStroke({'cmd'}, 'c')
        fastKeyStroke('right')
    end
end

function Yank.character()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('y')
        fastKeyStroke('l')
    else
        fastKeyStroke({'shift'}, 'left')
        fastKeyStroke({'cmd'}, 'c')
        fastKeyStroke('right')
    end
end

function Yank.toTopOfPage()
    if appIs(notion) then
        fastKeyStroke({'cmd'}, 'a')
        fastKeyStroke({'cmd'}, 'c')
        fastKeyStroke('right')
    else
        fastKeyStroke({'shift', 'cmd'}, 'up')
        fastKeyStroke({'cmd'}, 'c')
        fastKeyStroke('right')
    end
end

function Yank.untilForward()
    fastKeyStroke('escape')
    fastKeyStroke('y')
    fastKeyStroke('t')
end

function Yank.untilBackward()
    fastKeyStroke('escape')
    fastKeyStroke('y')
    fastKeyStroke({'shift'}, 't')
end

function Yank.all()
    fastKeyStroke({'cmd'}, 'a')
    fastKeyStroke({'cmd'}, 'c')

    if inCodeEditor() then
        fastKeyStroke('escape')
        fastKeyStroke('g')
        fastKeyStroke('g')
    else
        fastKeyStroke('right')
    end
end

return Yank
