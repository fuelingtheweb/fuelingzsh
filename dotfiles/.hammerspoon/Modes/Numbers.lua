local Numbers = {}
Numbers.__index = Numbers

Numbers.lookup = {
    y = '1',
    u = '2',
    i = '3',
    o = '4',
    p = '5',
    open_bracket = nil,
    close_bracket = nil,
    h = '6',
    j = '7',
    k = '8',
    l = '9',
    semicolon = '10',
    quote = '0',
    return_or_enter = nil,
    n = nil,
    m = nil,
    comma = nil,
    period = nil,
    slash = nil,
    right_shift = nil,
    spacebar = nil,
}

function Numbers.fallback(value)
    insertText(value)
end

return Numbers
