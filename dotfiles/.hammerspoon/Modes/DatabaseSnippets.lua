local DatabaseSnippets = {}
DatabaseSnippets.__index = DatabaseSnippets

DatabaseSnippets.lookup = {
    y = nil,
    u = nil,
    i = nil,
    o = nil,
    p = nil,
    open_bracket = nil,
    close_bracket = nil,
    h = nil,
    j = nil,
    k = 'select format(count(*), 0) from ',
    l = 'select * from ',
    semicolon = nil,
    quote = nil,
    return_or_enter = nil,
    n = nil,
    m = nil,
    comma = nil,
    period = nil,
    slash = nil,
    right_shift = nil,
    spacebar = nil,
}

function DatabaseSnippets.fallback(value)
    ks.type(value)
end

return DatabaseSnippets
