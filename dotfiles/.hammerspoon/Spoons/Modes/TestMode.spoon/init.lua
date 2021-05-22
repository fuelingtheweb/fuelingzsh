local TestMode = {}
TestMode.__index = TestMode

TerminalMode = hs.loadSpoon('Modes/TerminalMode')

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
    quote = nil,
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
    if inCodeEditor() then
        spoon.HyperMode.forceEscape()
    end
end

function TestMode.handle(key)
    if appIs(iterm) then
        TerminalMode.handle(key)
    elseif TestMode.lookup[key] then
        TestMode[TestMode.lookup[key]]()
    end
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
