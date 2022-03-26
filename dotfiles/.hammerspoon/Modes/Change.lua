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

    ks.escape().sequence({'c', 'i'}).fire(keystroke.mods, keystroke.key)

    if not hasValue({'s', 'd', 't'}, key) then BracketMatching.start() end
end

function Change.toEndOfWord()
    if TextManipulation.canManipulateWithVim() then
        ks.escape().sequence({'c', 'e'})
    else
        ks.shiftAlt('right').delete()
    end
end

function Change.subword()
    if TextManipulation.canManipulateWithVim() then
        ks.escape().sequence({'c', 'i'})

        if appIs(vscode) then
            ks.sequence({'\\', 'w'})
        else
            ks.key('q')
        end
    end
end

function Change.word()
    if TextManipulation.canManipulateWithVim() then
        ks.escape().sequence({'c', 'i', 'w'})
    elseif appIs(iterm) and not isAlfredVisible() then
        ks.escape().type('ciw')
    else
        ks.alt('delete')
    end
end

function Change.toEndOfLine()
    if TextManipulation.canManipulateWithVim() then
        ks.escape().shift('c')
    else
        ks.shiftCmd('right').delete()
    end
end

function Change.toBeginningOfLine()
    if TextManipulation.canManipulateWithVim() then
        ks.escape().shiftCmd('left').key('c')
    else
        ks.shiftCmd('left').delete()
    end
end

function Change.line()
    if TextManipulation.canManipulateWithVim() then
        ks.escape().sequence({'c', 'c'})
    elseif appIs(iterm) and not isAlfredVisible() then
        ks.escape().type('cc')
    else
        ks.cmd('left').shiftCmd('right').delete()
    end
end

function Change.character()
    if TextManipulation.canManipulateWithVim() then
        ks.ctrlAlt('a')

        if appIs(vscode) then ks.right() end
    end

    ks.delete()
end

function Change.below() ks.key('o') end

function Change.above() ks.shift('o') end

function Change.untilForward() ks.escape().sequence({'c', 't'}) end

function Change.untilBackward() ks.escape().key('c').shift('t') end

function Change.outer() Modal.enter('ChangeOuter') end

Modal.add({
    key = 'ChangeOuter',
    title = 'Change Outer',
    keys = {'t', 's', 'd', 'f', 'z', 'c', 'b'},
    callback = function(key)
        Modal.exit()

        keystroke = TextManipulation.wrapperKeyLookup[key]

        ks.escape().sequence({'c', 'a'}).fire(keystroke.mods, keystroke.key)

        if not hasValue({'s', 'd', 't'}, key) then
            BracketMatching.start()
        end
    end
})

return Change
