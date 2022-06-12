local SlackSnippets = {}
SlackSnippets.__index = SlackSnippets

SlackSnippets.lookup = {
    y = nil,
    u = nil,
    i = 'in',
    o = 'out',
    p = nil,
    open_bracket = nil,
    close_bracket = nil,
    h = fn.misc.showSnippets,
    j = nil,
    k = nil,
    l = 'lunch',
    semicolon = 'break',
    quote = 'eod',
    return_or_enter = 'back',
    n = 'ofn',
    m = nil,
    comma = nil,
    period = nil,
    slash = nil,
    right_shift = nil,
    spacebar = nil,
}

function SlackSnippets.fallback(value)
    ks.type('@' .. value)

    hs.timer.doAfter(.2, function()
        ks.slow().key('escape')
    end)
end

function SlackSnippets.eod()
    ks.type('@EOD').slow().shiftEnter()
    md.Paste.trimmed()
end

return SlackSnippets
