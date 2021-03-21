local PaneMode = {}
PaneMode.__index = PaneMode

PaneMode.lookup = {
    y = nil,
    u = nil,
    i = nil,
    o = nil,
    p = nil,
    open_bracket = 'destroy',
    close_bracket = nil,
    h = nil,
    j = 'focusPrevious',
    k = 'focusNext',
    l = 'splitRight',
    semicolon = 'toggleZoom',
    quote = nil,
    return_or_enter = nil,
    n = nil,
    m = 'splitBottom',
    comma = nil,
    period = nil,
    slash = nil,
    right_shift = nil,
    spacebar = nil,
}

function PaneMode.destroy()
    if appIncludes({atom, sublime}) then
        fastKeyStroke({'ctrl', 'alt', 'cmd'}, 'p')
        fastKeyStroke('o')
        fastKeyStroke('d')
        fastKeyStroke('s')
    elseif appIs(iterm) then
        fastKeyStroke({'cmd'}, 'w')
    end
end

function PaneMode.splitRight()
    if appIncludes({atom, sublime}) then
        fastKeyStroke({'ctrl', 'alt', 'cmd'}, 'p')
        fastKeyStroke('o')
        fastKeyStroke('c')
        fastKeyStroke('l')
    elseif appIs(iterm) then
        fastKeyStroke({'cmd'}, 'd')
    end
end

function PaneMode.splitBottom()
    if appIncludes({atom, sublime}) then
        fastKeyStroke({'ctrl', 'alt', 'cmd'}, 'p')
        fastKeyStroke('o')
        fastKeyStroke('c')
        fastKeyStroke('j')
    end
end

function PaneMode.toggleZoom()
    if appIncludes({atom, sublime}) then
        fastKeyStroke({'ctrl', 'alt', 'cmd'}, 'p')
        fastKeyStroke('o')
        fastKeyStroke('z')
    elseif appIs(iterm) then
        fastKeyStroke({'shift', 'cmd'}, 'return')
    end
end

function PaneMode.focusPrevious()
    if appIs(chrome) and stringContains('Google Sheets', currentTitle()) then
        fastKeyStroke({'alt'}, 'up')
    elseif appIncludes({atom, sublime}) then
        fastKeyStroke({'ctrl', 'alt', 'cmd'}, 'p')
        fastKeyStroke('o')
        fastKeyStroke('h')
    elseif appIs(transmit) then
        fastKeyStroke({'alt', 'cmd'}, 'left')
    else
        fastKeyStroke({'cmd'}, '[')
    end
end

function PaneMode.focusNext()
    if appIs(chrome) and stringContains('Google Sheets', currentTitle()) then
        fastKeyStroke({'alt'}, 'down')
    elseif appIncludes({atom, sublime}) then
        fastKeyStroke({'ctrl', 'alt', 'cmd'}, 'p')
        fastKeyStroke('o')
        fastKeyStroke('l')
    elseif appIs(transmit) then
        fastKeyStroke({'alt', 'cmd'}, 'right')
    else
        fastKeyStroke({'cmd'}, ']')
    end
end

return PaneMode
