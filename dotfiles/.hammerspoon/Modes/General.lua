local General = {}
General.__index = General

General.lookup = {
    y = '&',
    u = '_',
    i = '-',
    o = '+',
    p = '|',
    open_bracket = 'openParens',
    close_bracket = 'closeParens',
    h = '#',
    j = '@',
    k = '$',
    l = '- ',
    semicolon = '!',
    quote = 'equals',
    return_or_enter = nil,
    n = '`',
    m = 'multiply',
    comma = '%',
    period = 'methodChain',
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

function General.equals()
    ks.key('=')
end

function General.multiply()
    ks.shift('8')
end

function General.methodChain()
    ks.type('->')
    -- Modal.enter('CodeSnippets:callFunction')
end

function General.fallback(value)
    ks.type(value)
end

return General
