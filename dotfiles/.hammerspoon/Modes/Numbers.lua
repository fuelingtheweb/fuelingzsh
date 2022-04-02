local Numbers = {}
Numbers.__index = Numbers

Numbers.lookup = {
    y = nil,
    u = '1',
    i = '2',
    o = '3',
    p = nil,
    open_bracket = nil,
    close_bracket = nil,
    h = nil,
    j = '4',
    k = '5',
    l = '6',
    semicolon = '10',
    quote = '0',
    return_or_enter = nil,
    n = nil,
    m = '7',
    comma = '8',
    period = '9',
    slash = nil,
    right_shift = nil,
    spacebar = nil,
}

function Numbers.fallback(value)
    ks.type(value)
end

return Numbers
