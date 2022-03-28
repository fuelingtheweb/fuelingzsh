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
    ks.altCmd('t')
end

function Test.all()
    ks.super('t')
end

function Test.last()
    ks.ctrlAlt('r')
end

function Test.method()
    ks.ctrlAlt('t')
end

function Test.hideOutput()
    ks.super(']')
end

return Test
