local TabMode = {}
TabMode.__index = TabMode

function TabMode.y()
end

function TabMode.u()
end

function TabMode.i()
    -- Go to first tab
    hs.eventtap.keyStroke({'cmd'}, '1')
end

function TabMode.o()
    -- Go to last tab
    hs.eventtap.keyStroke({'cmd'}, '9')
end

function TabMode.p()
    -- Chrome: Pin Tab
    hs.eventtap.keyStroke({}, 't', 0)
    hs.eventtap.keyStroke({}, 'p', 0)
end

function TabMode.open_bracket()
    TabMode.closeCurrent()
end

function TabMode.close_bracket()
    TabMode.moveToNewWindow()
end

function TabMode.h()
    TabMode.moveLeft()
end

function TabMode.j()
end

function TabMode.k()
end

function TabMode.l()
    TabMode.moveRight()
end

function TabMode.semicolon()
end

function TabMode.quote()
end

function TabMode.return_or_enter()
    TabMode.restore()
end

function TabMode.n()
    TabMode.new()
end

function TabMode.m()
end

function TabMode.comma()
    TabMode.closeAllToLeft()
end

function TabMode.period()
    TabMode.closeAllToRight()
end

function TabMode.slash()
    TabMode.closeAllOthers()
end

function TabMode.right_shift()
    TabMode.closeAll()
end

function TabMode.spacebar()
end

function TabMode.moveLeft()
    if appIs(chrome) then
        -- Vimium
        hs.eventtap.keyStroke({}, 'escape')
        hs.eventtap.keyStrokes('th')
    elseif appIs(atom) then
        hs.eventtap.keyStroke({'shift', 'alt', 'cmd'}, 'h')
    elseif appIs(sublime) then
        -- https://packagecontrol.io/packages/MoveTab
        hs.eventtap.keyStroke({'shift', 'alt', 'cmd'}, 'left')
    elseif appIs(iterm) then
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'left')
    end
end

function TabMode.moveRight()
    if appIs(chrome) then
        -- Vimium
        hs.eventtap.keyStroke({}, 'escape')
        hs.eventtap.keyStrokes('tl')
    elseif appIs(atom) then
        hs.eventtap.keyStroke({'shift', 'alt', 'cmd'}, 'l')
    elseif appIs(sublime) then
        -- https://packagecontrol.io/packages/MoveTab
        hs.eventtap.keyStroke({'shift', 'alt', 'cmd'}, 'right')
    elseif appIs(iterm) then
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'right')
    end
end

function TabMode.closeCurrent()
    closeWindow()
end

function TabMode.restore()
    hs.eventtap.keyStroke({'shift', 'cmd'}, 'T')
end

function TabMode.moveToNewWindow()
    if appIs(sublime) then
        hs.eventtap.keyStroke({'cmd'}, 'A')
        hs.eventtap.keyStroke({'cmd'}, 'C')
        hs.eventtap.keyStroke({'cmd'}, 'W')
        hs.eventtap.keyStroke({}, 'space')
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'N')
        hs.eventtap.keyStroke({}, 'P')
    elseif appIs(chrome) then
        hs.eventtap.keyStroke({'shift'}, 'W')
    end
end

function TabMode.new()
    if appIncludes({sublime, atom}) then
        hs.eventtap.keyStroke({'cmd'}, 'n', 0)
        hs.eventtap.keyStroke({}, 'i', 0)
        hs.eventtap.keyStroke({}, 'return', 0)
        hs.eventtap.keyStroke({}, 'up', 0)
    elseif appIs(finder) then
        hs.eventtap.keyStroke({'cmd'}, 'n', 0)
    else
        hs.eventtap.keyStroke({'cmd'}, 't', 0)
    end
end

function TabMode.closeAllToLeft()
    if appIs(chrome) then
        hs.eventtap.keyStrokes('txh')
    elseif appIncludes({atom, sublime}) then
        hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 'tab', 0)
        hs.eventtap.keyStroke({}, 'x', 0)
        hs.eventtap.keyStroke({}, 'h', 0)

        if appIs(sublime) then
            hs.eventtap.keyStrokes('Close Tabs to Left')
            hs.eventtap.keyStroke({}, 'return', 0)
        end
    end
end

function TabMode.closeAllToRight()
    if appIs(chrome) then
        hs.eventtap.keyStrokes('txl')
    elseif appIncludes({atom, sublime}) then
        hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 'tab', 0)
        hs.eventtap.keyStroke({}, 'x', 0)
        hs.eventtap.keyStroke({}, 'l', 0)

        if appIs(sublime) then
            hs.eventtap.keyStrokes('Close Tabs to Right')
            hs.eventtap.keyStroke({}, 'return', 0)
        end
    end
end

function TabMode.closeAllOthers()
    if appIs(chrome) then
        hs.eventtap.keyStrokes('tx;')
    elseif appIncludes({atom, sublime}) then
        hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 'tab', 0)
        hs.eventtap.keyStroke({}, 'x', 0)
        hs.eventtap.keyStroke({}, ';', 0)

        if appIs(sublime) then
            hs.eventtap.keyStrokes('Close Other Tabs')
            hs.eventtap.keyStroke({}, 'return', 0)
        end
    end
end

function TabMode.closeAll()
    if appIs(atom) then
        hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 'x', 0)
    elseif appIs(sublime) then
        hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 'tab', 0)
        hs.eventtap.keyStroke({}, 'x', 0)
        hs.eventtap.keyStroke({}, ';', 0)

        if appIs(sublime) then
            hs.eventtap.keyStrokes('Close All Tabs')
            hs.eventtap.keyStroke({}, 'return', 0)
        end
    end
end

return TabMode
