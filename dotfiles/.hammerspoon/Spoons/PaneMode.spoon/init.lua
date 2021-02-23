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
        hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 'p', 0)
        hs.eventtap.keyStroke({}, 'o', 0)
        hs.eventtap.keyStroke({}, 'd', 0)
        hs.eventtap.keyStroke({}, 's', 0)
    elseif appIs(iterm) then
        hs.eventtap.keyStroke({'cmd'}, 'w', 0)
    end
end

function PaneMode.splitRight()
    if appIncludes({atom, sublime}) then
        hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 'p', 0)
        hs.eventtap.keyStroke({}, 'o', 0)
        hs.eventtap.keyStroke({}, 'c', 0)
        hs.eventtap.keyStroke({}, 'l', 0)
    elseif appIs(iterm) then
        hs.eventtap.keyStroke({'cmd'}, 'd', 0)
    end
end

function PaneMode.splitBottom()
    if appIncludes({atom, sublime}) then
        hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 'p', 0)
        hs.eventtap.keyStroke({}, 'o', 0)
        hs.eventtap.keyStroke({}, 'c', 0)
        hs.eventtap.keyStroke({}, 'j', 0)
    end
end

function PaneMode.toggleZoom()
    if appIncludes({atom, sublime}) then
        hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 'p', 0)
        hs.eventtap.keyStroke({}, 'o', 0)
        hs.eventtap.keyStroke({}, 'z', 0)
    elseif appIs(iterm) then
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'return', 0)
    end
end

function PaneMode.focusPrevious()
    if appIs(chrome) and stringContains('Google Sheets', currentTitle()) then
        hs.eventtap.keyStroke({'alt'}, 'up')
    elseif appIncludes({atom, sublime}) then
        hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 'p', 0)
        hs.eventtap.keyStroke({}, 'o', 0)
        hs.eventtap.keyStroke({}, 'h', 0)
    elseif appIs(transmit) then
        hs.eventtap.keyStroke({'alt', 'cmd'}, 'left')
    else
        hs.eventtap.keyStroke({'cmd'}, '[')
    end
end

function PaneMode.focusNext()
    if appIs(chrome) and stringContains('Google Sheets', currentTitle()) then
        hs.eventtap.keyStroke({'alt'}, 'down')
    elseif appIncludes({atom, sublime}) then
        hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 'p', 0)
        hs.eventtap.keyStroke({}, 'o', 0)
        hs.eventtap.keyStroke({}, 'l', 0)
    elseif appIs(transmit) then
        hs.eventtap.keyStroke({'alt', 'cmd'}, 'right')
    else
        hs.eventtap.keyStroke({'cmd'}, ']')
    end
end

return PaneMode
