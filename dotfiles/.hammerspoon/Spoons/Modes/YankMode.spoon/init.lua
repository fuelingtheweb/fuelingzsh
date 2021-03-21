local YankMode = {}
YankMode.__index = YankMode

function YankMode.w()
    YankMode.word()
end

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

YankMode.lookup = {
    e = 'toEndOfWord',
    r = 'relativeFilePath',
    q = 'subword',
    w = 'word',
    a = 'toEndOfLine',
    g = 'toBeginningOfLine',
    v = 'line',
    x = 'character',
    caps_lock = 'all',
    q = 'viewPath',
}

function YankMode.handle(key)
    if YankMode[key] then
        YankMode[key]()
    elseif YankMode.lookup[key] then
        hs.execute("open -g 'hammerspoon://yank-" .. YankMode.lookup[key] .. "'")
    elseif TextManipulation.wrapperKeyLookup[key] then
        keystroke = TextManipulation.wrapperKeyLookup[key]

        fastKeyStroke('escape')
        fastKeyStroke('y')
        fastKeyStroke('i')
        fastKeyStroke(keystroke.mods, keystroke.key)
    end
end

hs.urlevent.bind('yank-toEndOfWord', function()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('y')
        fastKeyStroke('e')
    else
        fastKeyStroke({'shift', 'alt'}, 'right')
        fastKeyStroke({'cmd'}, 'c')
        fastKeyStroke('left')
    end
end)

hs.urlevent.bind('yank-relativeFilePath', function()
    if appIs(atom) then
        fastKeyStroke({'shift', 'ctrl', 'alt', 'cmd'}, 'y')
        fastKeyStroke({'shift', 'ctrl', 'alt', 'cmd'}, 'r')
    elseif appIs(sublime) then
        fastKeyStroke({'shift', 'ctrl', 'alt', 'cmd'}, 'y')
    end
end)

hs.urlevent.bind('yank-subword', function()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('y')
        fastKeyStroke('i')
        fastKeyStroke('q')
    end
end)

hs.urlevent.bind('yank-toEndOfLine', function()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('y')
        fastKeyStroke({'shift'}, '4')
    else
        fastKeyStroke({'shift', 'cmd'}, 'right')
        fastKeyStroke({'cmd'}, 'c')
        fastKeyStroke('left')
    end
end)

hs.urlevent.bind('yank-toBeginningOfLine', function()
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
end)

hs.urlevent.bind('yank-line', function()
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
end)

hs.urlevent.bind('yank-character', function()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('y')
        fastKeyStroke('l')
    else
        fastKeyStroke({'shift'}, 'left')
        fastKeyStroke({'cmd'}, 'c')
        fastKeyStroke('right')
    end
end)

hs.urlevent.bind('yank-all', function()
    fastKeyStroke({'cmd'}, 'a')
    fastKeyStroke({'cmd'}, 'c')

    if inCodeEditor() then
        fastKeyStroke('escape')
        fastKeyStroke('g')
        fastKeyStroke('g')
    else
        fastKeyStroke('right')
    end
end)

hs.urlevent.bind('yank-viewPath', function()
    fastKeyStroke('escape')
    fastKeyStroke('y')
    fastKeyStroke('i')
    fastKeyStroke("'")

    result = trim(hs.execute('/Users/nathan/.nvm/versions/node/v12.4.0/bin/node /Users/nathan/.fuelingzsh/bin/change-case/bin/index.js "path" "' .. hs.pasteboard.getContents() .. '"'))
    hs.pasteboard.setContents(result)
end)

return YankMode
