local Yank = {}
Yank.__index = Yank

Yank.lookup = {
    tab = 'untilBackward',
    q = 'subword',
    w = 'word',
    e = 'toEndOfWord',
    r = 'untilForward',
    t = 'withWrapperKey',
    caps_lock = 'all',
    a = 'toEndOfLine',
    s = 'withWrapperKey',
    d = 'withWrapperKey',
    f = 'withWrapperKey',
    g = 'toBeginningOfLine',
    left_shift = 'toTopOfPage',
    z = 'withWrapperKey',
    x = 'character',
    c = 'withWrapperKey',
    v = 'line',
    b = 'withWrapperKey',
    spacebar = nil,
}

function Yank.word()
    if TextManipulation.canManipulateWithVim() then
        ks.escape().sequence({'y', 'i', 'w'})
    else
        ks.shiftAlt('left').copy().right()
    end
end

function Yank.withWrapperKey(key)
    keystroke = TextManipulation.wrapperKeyLookup[key]

    ks.escape().sequence({'y', 'i'}).fire(keystroke.mods, keystroke.key)
end

function Yank.toEndOfWord()
    if TextManipulation.canManipulateWithVim() then
        ks.escape().sequence({'y', 'e'})
    else
        ks.shiftAlt('right').copy().left()
    end
end

function Yank.relativeFilePath()
    if inCodeEditor() then
        ks.super('y')
    end
end

function Yank.subword()
    if TextManipulation.canManipulateWithVim() then
        ks.escape().sequence({'y', 'i'})

        if appIs(vscode) then
            ks.sequence({'\\', 'w'})
        else
            ks.key('q')
        end
    end
end

function Yank.toEndOfLine()
    if TextManipulation.canManipulateWithVim() then
        ks.escape().key('y').shift('4')
    else
        ks.shiftCmd('right').copy().left()
    end
end

function Yank.toBeginningOfLine()
    if TextManipulation.canManipulateWithVim() then
        ks.escape().right().shiftCmd('left').key('y')
    else
        ks.shiftCmd('left').slow().copy().right()
    end
end

function Yank.line()
    if TextManipulation.canManipulateWithVim() then
        ks.escape().sequence({'y', 'y'})
    else
        ks.cmd('left').shiftCmd('right').copy().right()
    end
end

function Yank.character()
    if TextManipulation.canManipulateWithVim() then
        ks.escape().sequence({'y', 'l'})
    else
        ks.shift('left').copy().right()
    end
end

function Yank.toTopOfPage()
    if appIs(notion) then
        ks.cmd('a').copy().right()
    else
        ks.shiftCmd('up').copy().right()
    end
end

function Yank.untilForward()
    ks.escape().sequence({'y', 't'})
end

function Yank.untilBackward()
    ks.escape().key('y').shift('t')
end

function Yank.all()
    if inCodeEditor() then
        ks.cmd('a').copy().escape().sequence({'g', 'g'})
    else
        ks.cmd('a').slow().copy().right()
    end
end

return Yank
