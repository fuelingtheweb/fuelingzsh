local Yarn = {}
Yarn.__index = Yarn

Yarn.lookup = {
    tab = nil,
    q = nil,
    w = 'ynw',
    e = nil,
    r = nil,
    t = nil,
    caps_lock = 'yni',
    a = nil,
    s = nil,
    d = 'ynd',
    f = nil,
    g = nil,
    left_shift = nil,
    z = nil,
    x = nil,
    c = nil,
    v = nil,
    b = 'ynp',
    spacebar = nil,
}

function Yarn.fallback(value)
    ks.typeAndEnter(value)
end

return Yarn
