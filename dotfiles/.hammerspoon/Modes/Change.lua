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
    spacebar = 'outer'
}

function Change.disableVim()
    hs.execute("open -g 'hammerspoon://text-disableVim'")
end

function Change.withWrapperKey(key)
    keystroke = TextManipulation.wrapperKeyLookup[key]

    ks.escape()
    ks.key('c')
    ks.key('i')
    ks.fire(keystroke.mods, keystroke.key)

    if not hasValue({'s', 'd', 't'}, key) then BracketMatching.start() end
end

function Change.toEndOfWord()
    if TextManipulation.canManipulateWithVim() then
        ks.escape()
        ks.key('c')
        ks.key('e')
    else
        ks.shiftAlt('right')
        ks.key('delete')
    end
end

function Change.subword()
    if TextManipulation.canManipulateWithVim() then
        ks.escape()
        ks.key('c')
        ks.key('i')

        if appIs(vscode) then
            ks.key('\\')
            ks.key('w')
        else
            ks.key('q')
        end
    end
end

function Change.word()
    if TextManipulation.canManipulateWithVim() then
        ks.escape()
        ks.key('c')
        ks.key('i')
        ks.key('w')
    elseif appIs(iterm) and not isAlfredVisible() then
        ks.escape()
        insertText('ciw')
    else
        ks.alt('delete')
    end
end

function Change.toEndOfLine()
    if TextManipulation.canManipulateWithVim() then
        ks.escape()
        ks.shift('c')
    else
        ks.shiftCmd('right')
        ks.key('delete')
    end
end

function Change.toBeginningOfLine()
    if TextManipulation.canManipulateWithVim() then
        ks.escape()
        ks.shiftCmd('left')
        ks.key('c')
    else
        ks.shiftCmd('left')
        ks.key('delete')
    end
end

function Change.line()
    if TextManipulation.canManipulateWithVim() then
        ks.escape()
        ks.key('c')
        ks.key('c')
    elseif appIs(iterm) and not isAlfredVisible() then
        ks.escape()
        insertText('cc')
    else
        ks.cmd('left')
        ks.shiftCmd('right')
        ks.key('delete')
    end
end

function Change.character()
    if TextManipulation.canManipulateWithVim() then
        ks.ctrlAlt('a')

        if appIs(vscode) then ks.key('right') end
    end

    ks.key('delete')
end

function Change.below() ks.key('o') end

function Change.above() ks.shift('o') end

function Change.untilForward()
    ks.escape()
    ks.key('c')
    ks.key('t')
end

function Change.untilBackward()
    ks.escape()
    ks.key('c')
    ks.shift('t')
end

function Change.outer() Modal.enter('ChangeOuter') end

Modal.add({
    key = 'ChangeOuter',
    title = 'Change Outer',
    keys = {'t', 's', 'd', 'f', 'z', 'c', 'b'},
    callback = function(key)
        Modal.exit()

        keystroke = TextManipulation.wrapperKeyLookup[key]

        ks.escape()
        ks.key('c')
        ks.key('a')
        ks.fire(keystroke.mods, keystroke.key)

        if not hasValue({'s', 'd', 't'}, key) then
            BracketMatching.start()
        end
    end
})

return Change
