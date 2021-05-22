local GeneralMode = {}
GeneralMode.__index = GeneralMode

GeneralMode.lookup = {
    e = '!',
    a = '@',
    d = '$',

    y = '&',
    u = '_',
    i = '-',
    o = '+',
    p = '|',
    open_bracket = 'openParens',
    close_bracket = 'closeParens',
    h = '#',
    j = nil,
    k = nil,
    l = '- ',
    semicolon = nil,
    quote = 'equals',
    return_or_enter = nil,
    n = '`',
    m = 'multiply',
    comma = '%',
    period = '->',
    slash = '~',
    right_shift = nil,
    spacebar = nil,
}

function GeneralMode.openParens()
    fastKeyStroke({'shift'}, '9')
end

function GeneralMode.closeParens()
    fastKeyStroke({'shift'}, '0')
end

function GeneralMode.equals()
    fastKeyStroke('=')
end

function GeneralMode.multiply()
    fastKeyStroke({'shift'}, '8')
end

function GeneralMode.fallback(value)
    insertText(value)
end

return GeneralMode
