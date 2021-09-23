local ChangeMode = {}
ChangeMode.__index = ChangeMode

ChangeMode.lookup = {
    tab = nil,
    q = 'subword',
    w = 'word',
    e = 'toEndOfWord',
    r = 'outer',
    t = 'withWrapperKey',
    caps_lock = 'disableVim',
    a = 'toEndOfLine',
    s = 'withWrapperKey',
    d = 'withWrapperKey',
    f = 'withWrapperKey',
    g = 'toBeginningOfLine',
    left_shift = {'below', 'above'},
    z = 'withWrapperKey',
    x = 'character',
    c = 'withWrapperKey',
    v = 'line',
    b = 'withWrapperKey',
    spacebar = nil,
}

function ChangeMode.disableVim()
    hs.execute("open -g 'hammerspoon://text-disableVim'")
end

function ChangeMode.withWrapperKey(key)
    keystroke = TextManipulation.wrapperKeyLookup[key]

    fastKeyStroke('escape')
    fastKeyStroke('c')
    fastKeyStroke('i')
    fastKeyStroke(keystroke.mods, keystroke.key)

    if not hasValue({'s', 'd', 't'}, key) then
        BracketMatching.start()
    end
end

function ChangeMode.toEndOfWord()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('c')
        fastKeyStroke('e')
    else
        fastKeyStroke({'shift', 'alt'}, 'right')
        fastKeyStroke('delete')
    end
end

function ChangeMode.subword()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('c')
        fastKeyStroke('i')
        fastKeyStroke('q')
    end
end

function ChangeMode.word()
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
end

function ChangeMode.toEndOfLine()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke({'shift'}, 'c')
    else
        fastKeyStroke({'shift', 'cmd'}, 'right')
        fastKeyStroke('delete')
    end
end

function ChangeMode.toBeginningOfLine()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke({'shift', 'cmd'}, 'left')
        fastKeyStroke('c')
    else
        fastKeyStroke({'shift', 'cmd'}, 'left')
        fastKeyStroke('delete')
    end
end

function ChangeMode.line()
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
end

function ChangeMode.character()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke({'ctrl', 'alt'}, 'a')
    end

    fastKeyStroke('delete')
end

function ChangeMode.below()
    fastKeyStroke('o')
end

function ChangeMode.above()
    fastKeyStroke({'shift'}, 'o')
end

function ChangeMode.outer()
    Modal.enter('ChangeOuter')
end

Modal.add({
    key = 'ChangeOuter',
    title = 'Change Outer',
    keys = {'t', 's', 'd', 'f', 'z', 'c', 'b'},
    callback = function(key)
        Modal.exit()

        keystroke = TextManipulation.wrapperKeyLookup[key]

        fastKeyStroke('escape')
        fastKeyStroke('c')
        fastKeyStroke('a')
        fastKeyStroke(keystroke.mods, keystroke.key)

        if not hasValue({'s', 'd', 't'}, key) then
            BracketMatching.start()
        end
    end,
})

return ChangeMode
