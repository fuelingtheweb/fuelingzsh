local JumpTo = {}
JumpTo.__index = JumpTo

JumpTo.lookup = {
    tab = nil,
    q = nil,
    w = nil,
    e = nil,
    r = 'untilForward',
    t = 'previousBlock',
    caps_lock = ToBracket.to,
    a = nil,
    s = 'singleQuote',
    d = 'doubleQuote',
    f = 'parenthesis',
    g = nil,
    left_shift = ToBracket.toSecondary,
    z = 'backTick',
    x = nil,
    c = 'braces',
    v = 'nextBlock',
    b = 'brackets',
    spacebar = nil,
}

function JumpTo.singleQuote()
    ToBracket.toForward()
    ToBracket.actions.singleQuote()
end

function JumpTo.doubleQuote()
    ToBracket.toForward()
    ToBracket.actions.doubleQuote()
end

function JumpTo.backTick()
    ToBracket.toForward()
    ToBracket.actions.backTick()
end

function JumpTo.parenthesis()
    ToBracket.toForward()
    ToBracket.actions.parenthesis()
end

function JumpTo.braces()
    ToBracket.toForward()
    ToBracket.actions.braces()
end

function JumpTo.brackets()
    ToBracket.toForward()
    ToBracket.actions.brackets()
end

function JumpTo.previousBlock()
    if is.vimMode() then
        ks.shift('[')
    else
        ks.shiftCmd('left')
    end
end

function JumpTo.nextBlock()
    if is.vimMode() then
        ks.shift(']')
    else
        ks.shiftCmd('right')
    end
end

function JumpTo.untilForward()
    ks.escape().key('f')
end

return JumpTo
