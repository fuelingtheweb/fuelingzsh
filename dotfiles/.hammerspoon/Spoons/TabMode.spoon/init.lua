local obj = {}
obj.__index = obj

hs.urlevent.bind('tab-moveLeft', function()
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
end)

hs.urlevent.bind('tab-moveRight', function()
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
end)

hs.urlevent.bind('tab-moveToNewWindow', function()
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
end)

hs.urlevent.bind('tab-new', function()
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
end)

hs.urlevent.bind('tab-closeAllToLeft', function()
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
end)

hs.urlevent.bind('tab-closeAllToRight', function()
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
end)

hs.urlevent.bind('tab-closeAllOthers', function()
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
end)

return obj
