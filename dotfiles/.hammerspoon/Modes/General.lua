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
    right_shift = nil,
    spacebar = nil,
}

function General.openParens()
    fastKeyStroke({'shift'}, '9')
end

function General.closeParens()
    fastKeyStroke({'shift'}, '0')
end

function General.equals()
    fastKeyStroke('=')
end

function General.multiply()
    fastKeyStroke({'shift'}, '8')
end

function General.methodChain()
    insertText('->')
    Modal.enter('CodeSnippets:callFunction')
end

function General.fallback(value)
    insertText(value)
end

return General
