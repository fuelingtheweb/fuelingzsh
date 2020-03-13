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

hs.urlevent.bind('misc-openInSublimeMerge', function()
    path = currentTitle():match('~%S+')

    if path then
        hs.execute('/usr/local/bin/smerge "' .. path .. '"')
    end
end)

hs.urlevent.bind('misc-openInAtom', function()
    if appIs(iterm) then
        typeAndEnter('atom .')
    else
        triggerAlfredWorkflow('projects', 'com.alfredapp.mdeboer.atom')
    end
end)

hs.urlevent.bind('misc-openInChrome', function()
    customOpenInChrome()
end)

hs.urlevent.bind('misc-openInFinder', function()
    if appIs(iterm) then
        typeAndEnter('o.')
    end
end)

hs.urlevent.bind('misc-surround', function()
    hs.eventtap.keyStroke({'cmd'}, 'C')
    triggerAlfredWorkflow('surround', 'com.fuelingtheweb.surround')
end)

hs.urlevent.bind('moveTabLeft', function()
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

hs.urlevent.bind('moveTabRight', function()
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

return obj
