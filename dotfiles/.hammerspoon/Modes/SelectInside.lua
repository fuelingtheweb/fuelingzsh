local SelectInside = {}
SelectInside.__index = SelectInside

SelectInside.lookup = {
    tab = nil,
    q = 'subword',
    w = 'word',
    e = nil,
    r = nil,
    t = Brackets.selectInside,
    caps_lock = nil,
    a = 'all',
    s = Brackets.selectInside,
    d = Brackets.selectInside,
    f = Brackets.selectInside,
    g = nil,
    left_shift = nil,
    z = Brackets.selectInside,
    x = 'character',
    c = Brackets.selectInside,
    v = 'line',
    b = Brackets.selectInside,
    spacebar = nil,
}

function SelectInside.subword()
    if is.vimMode() then
        ks.escape().sequence({'v', 'i'})

        if is.vscode() then
            ks.sequence({'\\', 'w'})
        else
            ks.key('q')
        end
    end
end

function SelectInside.word()
    if is.vimMode() then
        ks.escape().sequence({'v', 'i', 'w'})
    else
        ks.shiftAlt('left')
    end
end

function SelectInside.line()
    if is.vimMode() then
        ks.escape().shift('v')
    else
        ks.cmd('left').shiftCmd('right')
    end
end

function SelectInside.character()
    if is.vimMode() then
        ks.escape().key('v')
    else
        ks.shift('left')
    end
end

function SelectInside.all()
    ks.cmd('a')
end

return SelectInside
