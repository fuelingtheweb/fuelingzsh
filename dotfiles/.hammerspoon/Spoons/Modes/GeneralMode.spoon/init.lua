local GeneralMode = {}
GeneralMode.__index = GeneralMode

GeneralMode.lookup = {
    e = '!',
    a = '@',
    d = '$',

    y = '&',
    u = '_',
    i = {'-', '- '},
    o = '+',
    p = '|',
    open_bracket = '(',
    close_bracket = ')',
    h = '#',
    j = nil,
    k = nil,
    l = nil,
    semicolon = nil,
    quote = '=',
    return_or_enter = nil,
    n = '`',
    m = 'multiply',
    comma = '%',
    period = '->',
    slash = '~',
    right_shift = nil,
    spacebar = nil,
}

function GeneralMode.multiply()
    fastKeyStroke({'shift'}, '8')
end

function GeneralMode.fallback(value)
    insertText(value)
end

return GeneralMode
