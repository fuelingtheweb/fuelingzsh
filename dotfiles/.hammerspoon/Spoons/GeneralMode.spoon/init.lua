local GeneralMode = {}
GeneralMode.__index = GeneralMode

function GeneralMode.e()
    hs.eventtap.keyStrokes('!')
end

function GeneralMode.y()
    hs.eventtap.keyStrokes('&')
end

function GeneralMode.u()
    hs.eventtap.keyStrokes('_')
end

function GeneralMode.i()
    hs.eventtap.keyStrokes('-')
end

function GeneralMode.o()
    hs.eventtap.keyStrokes('+')
end

function GeneralMode.p()
    hs.eventtap.keyStrokes('|')
end

function GeneralMode.open_bracket()
    hs.eventtap.keyStrokes('(')
end

function GeneralMode.close_bracket()
    hs.eventtap.keyStrokes(')')
end

function GeneralMode.a()
    hs.eventtap.keyStrokes('@')
end

function GeneralMode.d()
    hs.eventtap.keyStrokes('$')
end

function GeneralMode.h()
    hs.eventtap.keyStrokes('#')
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
    hs.eventtap.keyStrokes('=')
end

function GeneralMode.return_or_enter()
end

function GeneralMode.n()
    hs.eventtap.keyStrokes('`')
end

function GeneralMode.m()
    hs.eventtap.keyStrokes('*')
end

function GeneralMode.comma()
    hs.eventtap.keyStrokes('%')
end

function GeneralMode.period()
    hs.eventtap.keyStrokes('->')
end

function GeneralMode.slash()
    hs.eventtap.keyStrokes('~')
end

function GeneralMode.right_shift()
end

function GeneralMode.spacebar()
end

return GeneralMode
