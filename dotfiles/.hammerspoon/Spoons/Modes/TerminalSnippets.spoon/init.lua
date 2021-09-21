local TerminalSnippets = {}
TerminalSnippets.__index = TerminalSnippets

TerminalSnippets.lookup = {
    y = nil,
    u = nil,
    i = nil,
    o = nil,
    p = nil,
    open_bracket = nil,
    close_bracket = nil,
    h = ' --help ',
    j = nil,
    k = nil,
    l = nil,
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

function TerminalSnippets.fallback(value)
    insertText(value)
end

return TerminalSnippets
