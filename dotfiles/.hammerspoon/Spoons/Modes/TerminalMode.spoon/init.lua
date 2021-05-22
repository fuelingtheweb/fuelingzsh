local TerminalMode = {}
TerminalMode.__index = TerminalMode

TerminalMode.lookup = {
    y = nil,
    u = nil,
    i = nil,
    o = nil,
    p = nil,
    open_bracket = nil,
    close_bracket = nil,
    h = nil,
    j = nil,
    k = nil,
    l = 'list',
    semicolon = nil,
    quote = nil,
    return_or_enter = nil,
    n = nil,
    m = nil,
    comma = nil,
    period = nil,
    slash = 'navigate',
    right_shift = nil,
    spacebar = nil,
}

function TerminalMode.handle(key)
    if TerminalMode.lookup[key] then
        TerminalMode[TerminalMode.lookup[key]]()
    end
end

function TerminalMode.list()
    typeAndEnter('ll')
end

function TerminalMode.navigate()
    insertText('cd ')
end

return TerminalMode
