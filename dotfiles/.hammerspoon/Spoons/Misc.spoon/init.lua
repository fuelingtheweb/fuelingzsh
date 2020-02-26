local obj = {}
obj.__index = obj

hs.urlevent.bind('misc-closeAllWindows', function()
    hs.eventtap.keyStroke({'shift', 'cmd'}, 'W')
    if appIs(chrome) then
        hs.timer.doAfter(1, function()
            app = hs.application.frontmostApplication()
            if next(app:visibleWindows()) == nil then
                app:hide()
            end
        end)
    end
end)

hs.urlevent.bind('misc-scroll', function()
    if appIs(notion) then
        hs.eventtap.keyStroke({}, 'down')
        hs.eventtap.keyStroke({}, 'down')
        hs.eventtap.keyStroke({}, 'down')
        hs.eventtap.keyStroke({}, 'down')
    else
        hs.eventtap.keyStroke({}, 'pagedown')
    end
end)

hs.urlevent.bind('misc-focusPrevious', function()
    if appIs(chrome) and stringContains('Google Sheets', currentTitle()) then
        hs.eventtap.keyStroke({'alt',}, 'up')
    elseif appIs(sublime) then
        hs.eventtap.keyStrokes(':oh')
    else
        hs.eventtap.keyStroke({'cmd'}, '[')
    end
end)

hs.urlevent.bind('misc-focusNext', function()
    if appIs(chrome) and stringContains('Google Sheets', currentTitle()) then
        hs.eventtap.keyStroke({'alt',}, 'down')
    elseif appIs(sublime) then
        hs.eventtap.keyStrokes(':ol')
    else
        hs.eventtap.keyStroke({'cmd'}, ']')
    end
end)

hs.urlevent.bind('misc-toggleSidebar', function()
    if appIs(finder) then
        hs.eventtap.keyStroke({'alt', 'cmd'}, 's')
    else
        hs.eventtap.keyStroke({'cmd'}, '\\')
    end
end)

hs.urlevent.bind('misc-openSublimeMerge', function()
    if appIs(atom) then
        path = currentTitle():match('~%S+')

        if path then
            hs.execute('/usr/local/bin/smerge "' .. path .. '"')
        end
    end
end)

return obj