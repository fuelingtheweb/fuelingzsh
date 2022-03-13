local Pane = {}
Pane.__index = Pane

Pane.lookup = {
    y = nil,
    u = nil,
    i = nil,
    o = nil,
    p = nil,
    open_bracket = nil,
    close_bracket = nil,
    h = nil,
    j = 'focusPrevious',
    k = 'focusNext',
    l = 'splitRight',
    semicolon = 'toggleZoom',
    quote = 'focusOtherSide',
    return_or_enter = nil,
    n = 'splitBottom',
    m = 'destroy',
    comma = nil,
    period = nil,
    slash = nil,
    right_shift = nil,
    spacebar = nil
}

function Pane.destroy()
    if appIncludes({atom, sublime}) then
        fastSuperKeyStroke('p')
        fastKeyStroke('o')
        fastKeyStroke('d')
        fastKeyStroke('s')
    elseif appIs(vscode) then
        fastSuperKeyStroke('p')
        fastSuperKeyStroke('d')
    elseif appIs(iterm) then
        fastKeyStroke({'cmd'}, 'w')
    end
end

function Pane.splitRight()
    if appIncludes({atom, sublime}) then
        fastSuperKeyStroke('p')
        fastKeyStroke('o')
        fastKeyStroke('c')
        fastKeyStroke('l')
    elseif appIs(vscode) then
        fastSuperKeyStroke('p')
        fastSuperKeyStroke('l')
    elseif appIs(iterm) then
        fastKeyStroke({'cmd'}, 'd')
    end
end

function Pane.splitBottom()
    if appIncludes({atom, sublime}) then
        fastKeyStroke({'ctrl', 'alt', 'cmd'}, 'p')
        fastKeyStroke('o')
        fastKeyStroke('c')
        fastKeyStroke('j')
    end
end

function Pane.toggleZoom()
    if appIncludes({atom, sublime}) then
        fastKeyStroke({'ctrl', 'alt', 'cmd'}, 'p')
        fastKeyStroke('o')
        fastKeyStroke('z')
    elseif appIs(iterm) then
        fastKeyStroke({'shift', 'cmd'}, 'return')
    end
end

function Pane.focusPrevious()
    if appIs(chrome) and stringContains('Google Sheets', currentTitle()) then
        fastKeyStroke({'alt'}, 'up')
    elseif appIncludes({atom, sublime}) then
        fastSuperKeyStroke('p')
        fastKeyStroke('o')
        fastKeyStroke('h')
    elseif appIs(vscode) then
        fastSuperKeyStroke('p')
        fastSuperKeyStroke('k')
    elseif appIs(transmit) then
        fastKeyStroke({'alt', 'cmd'}, 'left')
    elseif appIs(tableplus) then
        fastKeyStroke({'alt', 'cmd'}, '[')
    else
        fastKeyStroke({'cmd'}, '[')
    end
end

function Pane.focusNext()
    if appIs(chrome) and stringContains('Google Sheets', currentTitle()) then
        fastKeyStroke({'alt'}, 'down')
    elseif appIncludes({atom, sublime}) then
        fastSuperKeyStroke('p')
        fastKeyStroke('o')
        fastKeyStroke('l')
    elseif appIs(vscode) then
        fastSuperKeyStroke('p')
        fastSuperKeyStroke('j')
    elseif appIs(transmit) then
        fastKeyStroke({'alt', 'cmd'}, 'right')
    elseif appIs(tableplus) then
        fastKeyStroke({'alt', 'cmd'}, ']')
    else
        fastKeyStroke({'cmd'}, ']')
    end
end

function Pane.focusOtherSide()
    if appIs(vscode) then
        fastSuperKeyStroke('p')
        fastSuperKeyStroke(';')
    end
end

return Pane
