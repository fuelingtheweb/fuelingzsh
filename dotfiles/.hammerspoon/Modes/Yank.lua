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
    spacebar = nil
}

function Yank.word()
    if TextManipulation.canManipulateWithVim() then
        ks.escape()
        ks.key('y')
        ks.key('i')
        ks.key('w')
    else
        ks.shiftAlt('left')
        ks.cmd('c')
        ks.key('right')
    end
end

function Yank.withWrapperKey(key)
    keystroke = TextManipulation.wrapperKeyLookup[key]

    ks.escape()
    ks.key('y')
    ks.key('i')
    ks.fire(keystroke.mods, keystroke.key)
end

function Yank.toEndOfWord()
    if TextManipulation.canManipulateWithVim() then
        ks.escape()
        ks.key('y')
        ks.key('e')
    else
        ks.shiftAlt('right')
        ks.cmd('c')
        ks.key('left')
    end
end

function Yank.relativeFilePath() if inCodeEditor() then ks.super('y') end end

function Yank.subword()
    if TextManipulation.canManipulateWithVim() then
        ks.escape()
        ks.key('y')
        ks.key('i')

        if appIs(vscode) then
            ks.key('\\')
            ks.key('w')
        else
            ks.key('q')
        end
    end
end

function Yank.toEndOfLine()
    if TextManipulation.canManipulateWithVim() then
        ks.escape()
        ks.key('y')
        ks.shift('4')
    else
        ks.shiftCmd('right')
        ks.cmd('c')
        ks.key('left')
    end
end

function Yank.toBeginningOfLine()
    if TextManipulation.canManipulateWithVim() then
        ks.escape()
        ks.key('right')
        ks.shiftCmd('left')
        ks.key('y')
    else
        ks.shiftCmd('left')
        ks.slow().cmd('c')
        ks.key('right')
    end
end

function Yank.line()
    if TextManipulation.canManipulateWithVim() then
        ks.escape()
        ks.key('y')
        ks.key('y')
    else
        ks.cmd('left')
        ks.shiftCmd('right')
        ks.cmd('c')
        ks.key('right')
    end
end

function Yank.character()
    if TextManipulation.canManipulateWithVim() then
        ks.escape()
        ks.key('y')
        ks.key('l')
    else
        ks.shift('left')
        ks.cmd('c')
        ks.key('right')
    end
end

function Yank.toTopOfPage()
    if appIs(notion) then
        ks.cmd('a')
        ks.cmd('c')
        ks.key('right')
    else
        ks.shiftCmd('up')
        ks.cmd('c')
        ks.key('right')
    end
end

function Yank.untilForward()
    ks.escape()
    ks.key('y')
    ks.key('t')
end

function Yank.untilBackward()
    ks.escape()
    ks.key('y')
    ks.shift('t')
end

function Yank.all()

    if inCodeEditor() then
        ks.cmd('a')
        ks.cmd('c')

        ks.escape()
        ks.key('g')
        ks.key('g')
    else
        ks.cmd('a')
        ks.slow().cmd('c')

        ks.key('right')
    end
end

return Yank
