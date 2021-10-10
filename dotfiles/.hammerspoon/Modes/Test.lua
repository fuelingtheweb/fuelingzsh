local TestMode = {}
TestMode.__index = TestMode

TestMode.lookup = {
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

function TestMode.before()
    md.Hyper.forceEscape()
end

function TestMode.class()
    if appIs(atom) then
        fastKeyStroke({'alt', 'cmd'}, 't')
    end
end

function TestMode.all()
    if appIs(atom) then
        fastKeyStroke({'ctrl', 'alt', 'cmd'}, 't')
    end
end

function TestMode.last()
    if appIs(atom) then
        fastKeyStroke({'ctrl', 'alt'}, 'r')
    end
end

function TestMode.method()
    if appIs(atom) then
        fastKeyStroke({'ctrl', 'alt'}, 't')
    end
end

function TestMode.hideOutput()
    if appIs(atom) then
        fastKeyStroke({'ctrl', 'alt', 'cmd'}, ']')
    end
end

return TestMode
