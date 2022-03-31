local Paste = {}
Paste.__index = Paste

Paste.lookup = {
    tab = 'pasteNext',
    q = 'subword',
    w = 'word',
    e = 'toEndOfWord',
    r = nil,
    t = Brackets.pasteInside,
    caps_lock = nil,
    a = 'toEndOfLine',
    s = Brackets.pasteInside,
    d = Brackets.pasteInside,
    f = Brackets.pasteInside,
    g = 'toBeginningOfLine',
    left_shift = {'primaryVim', 'secondaryVim'},
    z = Brackets.pasteInside,
    x = 'character',
    c = Brackets.pasteInside,
    v = 'line',
    b = Brackets.pasteInside,
    spacebar = ks.paste,
}

function Paste.before()
    spoon.KarabinerHandler.currentKey = nil
end

function Paste.toEndOfWord()
    Paste.pastePending(
        function() ks.sequence({'v', 'e'}) end,
        function() ks.shiftAlt('right') end
    )
end

function Paste.subword()
    Paste.pastePending(
        function() md.SelectInside.subword() end,
        function() ks.shiftAlt('left') end
    )
end

function Paste.word()
    Paste.pastePending(
        function() ks.sequence({'v', 'i', 'w'}) end,
        function() ks.shiftAlt('left') end
    )
end

function Paste.toEndOfLine()
    Paste.pastePending(
        function() ks.key('v').shift('4') end,
        function() ks.shiftCmd('right') end
    )
end

function Paste.toBeginningOfLine()
    Paste.pastePending(
        function() ks.shiftCmd('left') end,
        function() ks.shiftCmd('left') end
    )
end

function Paste.line()
    Paste.pastePending(
        function() ks.shift('v') end,
        function() ks.cmd('left').shiftCmd('right') end
    )
end

function Paste.character()
    Paste.pastePending(
        function() ks.key('v') end,
        function() ks.shift('left') end
    )
end

function Paste.pastePending(selectTextWhenInVim, selectTextWhenInDefault)
    Paste.selectText(selectTextWhenInVim, selectTextWhenInDefault)
    Paste.pasteFirst()
end

function Paste.selectText(selectTextWhenInVim, selectTextWhenInDefault)
    if is.vimMode() then
        ks.escape()
        selectTextWhenInVim()
    else
        selectTextWhenInDefault()
    end
end

function Paste.pasteFirst()
    if is.vimMode() then
        Paste.primaryVim()
    else
        Paste.default()
    end
end

function Paste.pasteNext()
    fn.Alfred.run('paste:next', 'com.fuelingtheweb.commands')
end

function Paste.primaryVim()
    ks.key('p')
end

function Paste.secondaryVim()
    ks.shift('p')
end

function Paste.backward()
    if is.codeEditor() then
        ks.shift('p')
    end
end

return Paste
