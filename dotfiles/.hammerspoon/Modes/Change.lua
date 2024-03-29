local Change = {}
Change.__index = Change

Change.lookup = {
    tab = 'untilBackward',
    q = 'subword',
    w = 'word',
    e = 'toEndOfWord',
    r = 'untilForward',
    t = Brackets.changeInside,
    caps_lock = TextManipulation.disableVim,
    a = 'toEndOfLine',
    s = Brackets.changeInside,
    d = Brackets.changeInside,
    f = Brackets.changeInside,
    g = 'toBeginningOfLine',
    left_shift = nil,
    z = Brackets.changeInside,
    x = 'character',
    c = Brackets.changeInside,
    v = 'line',
    b = Brackets.changeInside,
    spacebar = 'outer',
}

function Change.toEndOfWord()
    if is.vimMode() then
        ks.escape().sequence({'c', 'e'})
    else
        ks.shiftAlt('right').delete()
    end
end

function Change.subword()
    if is.vimMode() then
        ks.escape().sequence({'c', 'i'})

        if is.vscode() then
            ks.sequence({'\\', 'w'})
        else
            ks.key('q')
        end
    end
end

function Change.word()
    if is.vimMode() then
        ks.escape().sequence({'c', 'i', 'w'})
    else
        ks.alt('delete')
    end
end

function Change.toEndOfLine()
    if is.vimMode() then
        ks.escape().shift('c')
    else
        ks.shiftCmd('right').delete()
    end
end

function Change.toBeginningOfLine()
    if is.vimMode() then
        ks.left().right().escape().sequence({'v', '0', 'c'})
    else
        ks.shiftCmd('left').delete()
    end
end

function Change.line()
    if is.vimMode() then
        ks.escape().sequence({'c', 'c'})
    elseif is.iterm() and not fn.Alfred.visible() then
        ks.cmd('delete')
    else
        ks.cmd('left').shiftCmd('right').delete()
    end
end

function Change.character()
    if is.vscode() and is.vimMode() then
        ks.escape().key('a').delete()
    elseif is.vimMode() then
        ks.ctrlAlt('a').delete()
    else
        ks.delete()
    end
end

function Change.untilForward()
    ks.escape().sequence({'c', 't'})
end

function Change.untilBackward()
    ks.escape().key('c').shift('t')
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

        keystroke = Brackets.actionInsideLookup[key]

        ks.escape().sequence({'c', 'a'}).fire(keystroke.mods, keystroke.key)

        if key == 'f' or (key == 'b' and is.php()) then
            -- Brackets.start()
        end
    end,
})

return Change
