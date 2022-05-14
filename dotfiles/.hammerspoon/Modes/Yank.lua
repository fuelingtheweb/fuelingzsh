local Yank = {}
Yank.__index = Yank

Yank.lookup = {
    tab = 'untilBackward',
    q = 'subword',
    w = 'word',
    e = 'toEndOfWord',
    r = 'untilForward',
    t = Brackets.yankInside,
    caps_lock = 'all',
    a = 'toEndOfLine',
    s = Brackets.yankInside,
    d = Brackets.yankInside,
    f = Brackets.yankInside,
    g = 'toBeginningOfLine',
    left_shift = 'toTopOfPage',
    z = Brackets.yankInside,
    x = 'character',
    c = Brackets.yankInside,
    v = 'line',
    b = Brackets.yankInside,
    spacebar = nil,
}

function Yank.word()
    if is.vimMode() then
        ks.escape().sequence({'y', 'i', 'w'})
    else
        ks.shiftAlt('left').copy().right()
    end
end

function Yank.toEndOfWord()
    if is.vimMode() then
        ks.escape().sequence({'y', 'e'})
    else
        ks.shiftAlt('right').copy().left()
    end
end

function Yank.relativeFilePath()
    if is.codeEditor() then
        ks.super('y')
    end
end

function Yank.subword()
    if is.vimMode() then
        ks.escape().sequence({'y', 'i'})

        if is.vscode() then
            ks.sequence({'\\', 'w'})
        else
            ks.key('q')
        end
    end
end

function Yank.toEndOfLine()
    if is.vimMode() then
        ks.escape().key('y').shift('4')
    else
        ks.shiftCmd('right').copy().left()
    end
end

function Yank.toBeginningOfLine()
    if is.vscode() then
        ks.escape().key('v').shift('6').key('y')
    elseif is.vimMode() then
        ks.escape().right().shiftCmd('left').key('y')
    else
        ks.shiftCmd('left').slow().copy().right()
    end
end

function Yank.line()
    if is.vimMode() then
        ks.escape().sequence({'y', 'y'})
    else
        ks.cmd('left').shiftCmd('right').copy().right()
    end
end

function Yank.character()
    if is.vimMode() then
        ks.escape().sequence({'y', 'l'})
    else
        ks.shift('left').copy().right()
    end
end

function Yank.toTopOfPage()
    ks.shiftCmd('up').slow().copy().right()
end

function Yank.untilForward()
    ks.escape().sequence({'y', 't'})
end

function Yank.untilBackward()
    ks.escape().key('y').shift('t')
end

function Yank.all()
    if is.codeEditor() then
        ks.cmd('a').copy().escape().sequence({'g', 'g'})
    else
        ks.cmd('a').slow().copy().right()
    end
end

return Yank
