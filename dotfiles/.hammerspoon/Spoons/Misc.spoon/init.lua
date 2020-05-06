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

hs.urlevent.bind('misc-focusPrevious', function()
    if appIs(chrome) and stringContains('Google Sheets', currentTitle()) then
        hs.eventtap.keyStroke({'alt',}, 'up')
    elseif appIs(sublime) then
        hs.eventtap.keyStrokes(':oh')
    elseif appIs(atom) then
        hs.eventtap.keyStroke({'alt', 'cmd'}, 'h')
    else
        hs.eventtap.keyStroke({'cmd'}, '[')
    end
end)

hs.urlevent.bind('misc-focusNext', function()
    if appIs(chrome) and stringContains('Google Sheets', currentTitle()) then
        hs.eventtap.keyStroke({'alt',}, 'down')
    elseif appIs(sublime) then
        hs.eventtap.keyStrokes(':ol')
    elseif appIs(atom) then
        hs.eventtap.keyStroke({'alt', 'cmd'}, 'l')
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
    text = getSelectedText()
    if not appIncludes({atom, sublime}) and text then
        runGoogleSearch(text)
    elseif appIs(chrome) then
        hs.eventtap.keyStrokes('yy')
        openInChrome(getSelectedText())
    else
        customOpenInChrome()
    end
end)

hs.urlevent.bind('misc-openInFinder', function()
    if appIs(iterm) then
        typeAndEnter('o.')
    else
        path = currentTitle():match('~%S+')
        if path then
            hs.execute('open ' .. path)
        end
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

hs.urlevent.bind('deleteWord', function()
    if appIs(iterm) then
        hs.eventtap.keyStroke({'ctrl'}, 'w')
    else
        hs.eventtap.keyStroke({'alt'}, 'delete')
    end
end)

hs.urlevent.bind('searchTabs', function()
    if appIs(atom) then
        hs.eventtap.keyStroke({'cmd'}, 'b')
    elseif appIs(sublime) then
        hs.eventtap.keyStroke({'alt', 'shift'}, 'p')
    elseif appIs(chrome) then
        hs.eventtap.keyStrokes('T')
    else
        -- Witch: Search tabs
        hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd', 'shift'}, 'b')
    end
end)

hs.urlevent.bind('misc-copyAll', function()
    hs.eventtap.keyStroke({'cmd'}, 'A')
    hs.eventtap.keyStroke({'cmd'}, 'C')
    hs.eventtap.keyStroke({}, 'Right')
end)

hs.urlevent.bind('google-openAndReload', function()
    hs.application.get(apps['chrome']):activate()
    hs.eventtap.keyStroke({'cmd'}, 'R')
end)

hs.urlevent.bind('misc-saveAndReload', function()
    hs.eventtap.keyStroke({'cmd'}, 'S')
    hs.application.get(apps['chrome']):activate()
    hs.eventtap.keyStroke({'cmd'}, 'R')
end)

return obj
