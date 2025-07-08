local Test = {}
Test.__index = Test

Test.lookup = {
    y = nil,
    u = nil,
    i = 'allInTerminal',
    o = nil,
    p = nil,
    open_bracket = nil,
    close_bracket = nil,
    h = nil,
    j = 'toggleZenMode',
    k = 'class',
    l = 'allInEditor',
    semicolon = 'last',
    quote = nil,
    return_or_enter = nil,
    n = nil,
    m = 'method',
    comma = nil,
    period = nil,
    slash = nil,
    right_shift = nil,
    spacebar = 'toggleVscodeTerminal',
}

function Test.before()
    md.Hyper.forceEscape()
    ks.save();
end

function Test.class()
    ks.altCmd('t')
end

function Test.allInTerminal()
    hs.application.launchOrFocusByBundleID(warp)

    hs.timer.doAfter(0.1, function()
        ks.typeAndEnter('t')
    end)
end

function Test.allInEditor()
    ks.ctrlAlt('l')
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

function Test.toggleVscodeTerminal()
    ks.ctrl('`')
end

function Test.toggleZenMode()
    ks.super('z')
end

return Test
