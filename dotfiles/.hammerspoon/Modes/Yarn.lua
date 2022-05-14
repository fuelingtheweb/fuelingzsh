local Yarn = {}
Yarn.__index = Yarn

Yarn.lookup = {
    tab = nil,
    q = nil,
    w = 'yw',
    e = nil,
    r = nil,
    t = nil,
    caps_lock = 'yi',
    a = nil,
    s = nil,
    d = 'yd',
    f = nil,
    g = nil,
    left_shift = nil,
    z = nil,
    x = nil,
    c = nil,
    v = nil,
    b = 'yp',
    spacebar = nil,
}

function Yarn.fallback(value)
    ks.typeAndEnter(value)
end

return Yarn
