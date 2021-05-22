local MakeMode = {}
MakeMode.__index = MakeMode

MakeMode.lookup = {
    tab = nil,
    q = nil,
    w = nil,
    e = nil,
    r = nil,
    t = 'tag',
    caps_lock = nil,
    a = nil,
    s = 'singleQuote',
    d = 'doubleQuote',
    f = 'parenthesis',
    g = nil,
    left_shift = nil,
    z = 'backTick',
    x = nil,
    c = 'braces',
    v = nil,
    b = 'brackets',
    spacebar = 'space',
}

function MakeMode.fallback(bracket)
    BracketMatching.print(bracket)
end

return MakeMode
