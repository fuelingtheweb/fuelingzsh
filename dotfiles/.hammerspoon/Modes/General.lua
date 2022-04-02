local General = {}
General.__index = General

General.lookup = {
    y = '&',
    u = '_',
    i = 'openBraces',
    o = 'closeBraces',
    p = '|',
    open_bracket = '\\',
    close_bracket = nil,
    h = '#',
    j = 'openParens',
    k = 'closeParens',
    l = '- ',
    semicolon = '$',
    quote = '@',
    return_or_enter = nil,
    n = '!',
    m = cm.Code.null,
    comma = '`',
    period = '->',
    slash = '~',
    right_shift = '^',
    spacebar = nil,
}

function General.openParens()
    ks.shift('9')
end

function General.closeParens()
    ks.shift('0')
end

function General.openBraces()
    ks.shift('[')
end

function General.closeBraces()
    ks.shift(']')
end

function General.fallback(value)
    ks.type(value)
end

return General
