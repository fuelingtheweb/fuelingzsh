local Destroy = {}
Destroy.__index = Destroy

Destroy.lookup = {
    tab = 'untilBackward',
    q = 'subword',
    w = 'word',
    e = 'toEndOfWord',
    r = 'untilForward',
    t = Brackets.destroyInside,
    caps_lock = 'backward',
    a = 'toEndOfLine',
    s = Brackets.destroyInside,
    d = Brackets.destroyInside,
    f = Brackets.destroyInside,
    g = 'toBeginningOfLine',
    left_shift = Brackets.cancel,
    z = Brackets.destroyInside,
    x = 'character',
    c = Brackets.destroyInside,
    v = 'line',
    b = Brackets.destroyInside,
    spacebar = 'simpleDelete',
}

function Destroy.simpleDelete()
    if is.codeEditor() then
        Brackets.cancel()
        Brackets.start()
    else
        ks.delete()
    end
end

function Destroy.toEndOfWord()
    if is.vimMode() then
        ks.escape().sequence({'d', 'e'})
    else
        ks.shiftAlt('right').delete()
    end
end

function Destroy.subword()
    if is.vimMode() then
        ks.escape().sequence({'d', 'i'})

        if is.vscode() then
            ks.sequence({'\\', 'w'})
        else
            ks.key('q')
        end
    end
end

function Destroy.word()
    if is.vimMode() then
        ks.escape().sequence({'d', 'i', 'w'})
    elseif is.iterm() then
        ks.ctrl('w')
    else
        ks.alt('delete')
    end
end

function Destroy.toEndOfLine()
    if is.vimMode() then
        ks.escape().shift('d')
    else
        ks.shiftCmd('right').delete()
    end
end

function Destroy.toBeginningOfLine()
    if is.vimMode() then
        ks.escape()

        if is.vscode() then
            md.SelectUntil.beginningOfLine()
        else
            ks.shiftCmd('left')
        end

        ks.key('d')
    else
        ks.shiftCmd('left').delete()
    end
end

function Destroy.line()
    if is.vimMode() then
        ks.escape().sequence({'d', 'd'})
    elseif is.googleSheet() then
        ks.shift('space').shift('space').slow().copy()

        local text = trim(hs.pasteboard.getContents())
        if text == '' then
            ks.shift('space')
        end

        ks.altCmd('-').left()
    else
        ks.cmd('left').shiftCmd('right').delete()
    end
end

function Destroy.character()
    if is.vimMode() then
        ks.escape().key('x')
    else
        ks.delete()
    end
end

function Destroy.untilForward()
    ks.escape().sequence({'d', 't'})
end

function Destroy.untilBackward()
    ks.escape().key('d').shift('t')
end

function Destroy.backward()
    if is.codeEditor() then
        ks.super('v').escape().left().key('x')
    end
end

return Destroy
