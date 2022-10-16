local Tertiary = {}
Tertiary.__index = Tertiary

Tertiary.lookup = {
    tab = nil,
    q = nil,
    w = nil,
    e = nil,
    r = 'restart',
    t = nil,
    caps_lock = nil,
    a = nil,
    s = 'shutdown',
    d = nil,
    f = nil,
    g = nil,
    left_shift = nil,
    z = nil,
    x = 'vscodeExtensions',
    c = nil,
    v = nil,
    b = nil,
    spacebar = nil,
}

function Tertiary.vscodeExtensions()
    ks.shiftCmd('x')
end

function Tertiary.restart()
    fn.Alfred.search('restart')
end

function Tertiary.shutdown()
    fn.Alfred.search('shutdown')
end

return Tertiary
