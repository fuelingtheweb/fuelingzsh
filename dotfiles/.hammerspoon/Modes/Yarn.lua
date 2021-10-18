local Yarn = {}
Yarn.__index = Yarn

Yarn.lookup = {
    tab = nil,
    q = nil,
    w = 'yw',
    e = nil,
    r = nil,
    t = nil,
    caps_lock = nil,
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
    b = nil,
    spacebar = nil,
}

function Yarn.fallback(value)
    typeAndEnter(value)
end

return Yarn
