local Change = {}
Change.__index = Change

Change.lookup = {
    tab = 'untilBackward',
    q = 'subword',
    w = 'word',
    e = 'toEndOfWord',
    r = 'untilForward',
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
    spacebar = 'outer',
}

function Change.disableVim()
    hs.execute("open -g 'hammerspoon://text-disableVim'")
end

function Change.withWrapperKey(key)
    keystroke = TextManipulation.wrapperKeyLookup[key]

    fastKeyStroke('escape')
    fastKeyStroke('c')
    fastKeyStroke('i')
    fastKeyStroke(keystroke.mods, keystroke.key)

    if not hasValue({'s', 'd', 't'}, key) then
        BracketMatching.start()
    end
end

function Change.toEndOfWord()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('c')
        fastKeyStroke('e')
    else
        fastKeyStroke({'shift', 'alt'}, 'right')
        fastKeyStroke('delete')
    end
end

function Change.subword()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('c')
        fastKeyStroke('i')
        fastKeyStroke('q')
    end
end

function Change.word()
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

function Change.toEndOfLine()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke({'shift'}, 'c')
    else
        fastKeyStroke({'shift', 'cmd'}, 'right')
        fastKeyStroke('delete')
    end
end

function Change.toBeginningOfLine()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke({'shift', 'cmd'}, 'left')
        fastKeyStroke('c')
    else
        fastKeyStroke({'shift', 'cmd'}, 'left')
        fastKeyStroke('delete')
    end
end

function Change.line()
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

function Change.character()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke({'ctrl', 'alt'}, 'a')
    end

    fastKeyStroke('delete')
end

function Change.below()
    fastKeyStroke('o')
end

function Change.above()
    fastKeyStroke({'shift'}, 'o')
end

function Change.untilForward()
    fastKeyStroke('escape')
    fastKeyStroke('c')
    fastKeyStroke('t')
end

function Change.untilBackward()
    fastKeyStroke('escape')
    fastKeyStroke('c')
    fastKeyStroke({'shift'}, 't')
end

function Change.outer()
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

return Change
