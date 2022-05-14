local Artisan = {}
Artisan.__index = Artisan

Artisan.lookup = {
    y = nil,
    u = nil,
    i = nil,
    o = nil,
    p = nil,
    open_bracket = nil,
    close_bracket = nil,
    h = nil,
    j = nil,
    k = nil,
    l = nil,
    semicolon = 'a ',
    quote = nil,
    return_or_enter = nil,
    n = cm.Artisan.migrateFreshAndSeed,
    m = nil,
    comma = nil,
    period = nil,
    slash = nil,
    right_shift = nil,
    spacebar = nil,
}

function Artisan.fallback(value)
    ks.type(value)
end

return Artisan
