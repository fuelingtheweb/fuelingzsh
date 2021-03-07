local PaneMode = {}
PaneMode.__index = PaneMode

function PaneMode.y()
end

function PaneMode.u()
end

function PaneMode.i()
end

function PaneMode.o()
end

function PaneMode.p()
end

function PaneMode.open_bracket()
    PaneMode.destroy()
end

function PaneMode.close_bracket()
end

function PaneMode.h()
end

function PaneMode.j()
    PaneMode.focusPrevious()
end

function PaneMode.k()
    PaneMode.focusNext()
end

function PaneMode.l()
    PaneMode.splitRight()
end

function PaneMode.semicolon()
    PaneMode.toggleZoom()
end

function PaneMode.quote()
end

function PaneMode.return_or_enter()
end

function PaneMode.n()
end

function PaneMode.m()
    PaneMode.splitBottom()
end

function PaneMode.comma()
end

function PaneMode.period()
end

function PaneMode.slash()
end

function PaneMode.right_shift()
end

function PaneMode.spacebar()
end

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
