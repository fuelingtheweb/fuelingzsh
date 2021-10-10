local Test = {}
Test.__index = Test

Test.lookup = {
    y = nil,
    u = nil,
    i = nil,
    o = nil,
    p = nil,
    open_bracket = nil,
    close_bracket = nil,
    h = nil,
    j = nil,
    k = 'class',
    l = 'all',
    semicolon = nil,
    quote = 'last',
    return_or_enter = nil,
    n = nil,
    m = 'method',
    comma = nil,
    period = nil,
    slash = nil,
    right_shift = nil,
    spacebar = nil,
}

function Test.before()
    md.Hyper.forceEscape()
end

function Test.class()
    if appIs(atom) then
        fastKeyStroke({'alt', 'cmd'}, 't')
    end
end

function Test.all()
    if appIs(atom) then
        fastKeyStroke({'ctrl', 'alt', 'cmd'}, 't')
    end
end

function Test.last()
    if appIs(atom) then
        fastKeyStroke({'ctrl', 'alt'}, 'r')
    end
end

function Test.method()
    if appIs(atom) then
        fastKeyStroke({'ctrl', 'alt'}, 't')
    end
end

function Test.hideOutput()
    if appIs(atom) then
        fastKeyStroke({'ctrl', 'alt', 'cmd'}, ']')
    end
end

return Test
