local YankMode = {}
YankMode.__index = YankMode

YankMode.lookup = {
    tab = 'untilBackward',
    q = 'subword',
    w = 'word',
    e = 'toEndOfWord',
    r = 'untilForward',
    -- r = 'relativeFilePath',
    t = 'withWrapperKey',
    caps_lock = 'toTopOfPage',
    a = 'toEndOfLine',
    s = 'withWrapperKey',
    d = 'withWrapperKey',
    f = 'withWrapperKey',
    g = 'toBeginningOfLine',
    left_shift = 'viewPath',
    z = 'withWrapperKey',
    x = 'character',
    c = 'withWrapperKey',
    v = 'line',
    b = 'withWrapperKey',
    spacebar = nil,
}

function YankMode.word()
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

function YankMode.withWrapperKey(key)
    keystroke = TextManipulation.wrapperKeyLookup[key]

    fastKeyStroke('escape')
    fastKeyStroke('y')
    fastKeyStroke('i')
    fastKeyStroke(keystroke.mods, keystroke.key)
end

function YankMode.toEndOfWord()
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

function YankMode.relativeFilePath()
    if inCodeEditor() then
        fastKeyStroke({'ctrl', 'alt', 'cmd'}, 'y')
    end
end

function YankMode.subword()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('y')
        fastKeyStroke('i')
        fastKeyStroke('q')
    end
end

function YankMode.toEndOfLine()
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

function YankMode.toBeginningOfLine()
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

function YankMode.line()
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

function YankMode.character()
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

function YankMode.viewPath()
    fastKeyStroke('escape')
    fastKeyStroke('y')
    fastKeyStroke('i')
    fastKeyStroke("'")

    result = trim(hs.execute('/Users/nathan/.nvm/versions/node/v12.4.0/bin/node /Users/nathan/.fuelingzsh/bin/change-case/bin/index.js "path" "' .. hs.pasteboard.getContents() .. '"'))
    hs.pasteboard.setContents(result)
end

function YankMode.toTopOfPage()
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

function YankMode.untilForward()
    fastKeyStroke('escape')
    fastKeyStroke('y')
    fastKeyStroke('t')
end

function YankMode.untilBackward()
    fastKeyStroke('escape')
    fastKeyStroke('y')
    fastKeyStroke({'shift'}, 't')
end

return YankMode
