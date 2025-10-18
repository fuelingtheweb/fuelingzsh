local Destroy = {}
Destroy.__index = Destroy

Destroy.lookup = {
    tab = 'untilBackward',
    q = 'subword',
    w = 'word',
    e = 'toEndOfWord',
    r = 'untilForward',
    t = Brackets.destroyInside,
    caps_lock = 'all',
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
    spacebar = nil,
}

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

        local text = fn.clipboard.trimmed()
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

function Destroy.all()
    if is.codeEditor() then
        ks.escape().cmd('a').key('c').slow().enter().up()
    else
        ks.slow().cmd('a').delete()
    end
end

return Destroy
