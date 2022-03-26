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
    h = nil,
    j = nil,
    k = nil,
    l = 'lunch',
    semicolon = 'break',
    quote = nil,
    return_or_enter = 'back',
    n = 'ofn',
    m = nil,
    comma = nil,
    period = nil,
    slash = nil,
    right_shift = nil,
    spacebar = nil
}

function SlackSnippets.fallback(value)
    insertText('@' .. value)

    hs.timer.doAfter(.2, function() ks.slow().key('escape') end)
end

return SlackSnippets
