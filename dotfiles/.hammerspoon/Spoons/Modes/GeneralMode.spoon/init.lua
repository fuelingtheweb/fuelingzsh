local GeneralMode = {}
GeneralMode.__index = GeneralMode

function GeneralMode.e()
    insertText('!')
end

function GeneralMode.y()
    insertText('&')
end

function GeneralMode.u()
    insertText('_')
end

function GeneralMode.i()
    insertText('-')
end

function GeneralMode.o()
    insertText('+')
end

function GeneralMode.p()
    insertText('|')
end

function GeneralMode.open_bracket()
    insertText('(')
end

function GeneralMode.close_bracket()
    insertText(')')
end

function GeneralMode.a()
    insertText('@')
end

function GeneralMode.d()
    insertText('$')
end

function GeneralMode.h()
    insertText('#')
end

function GeneralMode.j()
end

function GeneralMode.k()
end

function GeneralMode.l()
end

function GeneralMode.semicolon()
end

function GeneralMode.quote()
    insertText('=')
end

function GeneralMode.return_or_enter()
end

function GeneralMode.n()
    insertText('`')
end

function GeneralMode.m()
    -- *
    fastKeyStroke({'shift'}, '8')
end

function GeneralMode.comma()
    insertText('%')
end

function GeneralMode.period()
    insertText('->')
end

function GeneralMode.slash()
    insertText('~')
end

function GeneralMode.right_shift()
end

function GeneralMode.spacebar()
end

return GeneralMode
