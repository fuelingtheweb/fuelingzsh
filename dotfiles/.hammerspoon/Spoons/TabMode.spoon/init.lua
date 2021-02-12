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
    end
end)

hs.urlevent.bind('tab-new', function()
    if appIncludes({sublime, atom}) then
        hs.eventtap.keyStroke({'cmd'}, 'n')
        hs.eventtap.keyStroke({}, 'i')
        hs.eventtap.keyStroke({}, 'return')
        hs.eventtap.keyStroke({}, 'up')
    elseif appIs(finder) then
        hs.eventtap.keyStroke({'cmd'}, 'n')
    else
        hs.eventtap.keyStroke({'cmd'}, 't')
    end
end)

return obj
