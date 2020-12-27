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
    elseif appIs(transmit) then
        hs.eventtap.keyStroke({'alt', 'cmd'}, 'left')
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
    elseif appIs(transmit) then
        hs.eventtap.keyStroke({'alt', 'cmd'}, 'right')
    else
        hs.eventtap.keyStroke({'cmd'}, ']')
    end
end)

hs.urlevent.bind('misc-toggleSidebar', function()
    if appIs(finder) then
        hs.eventtap.keyStroke({'alt', 'cmd'}, 's')
    elseif appIs(sublimeMerge) then
        hs.eventtap.keyStroke({'cmd'}, 'K')
        hs.eventtap.keyStroke({'cmd'}, 'B')
    else
        hs.eventtap.keyStroke({'cmd'}, '\\')
    end
end)

hs.urlevent.bind('misc-openInSublimeMerge', function()
    if appIs(iterm) then
        return typeAndEnter('smerge .')
    end

    path = currentTitle():match('~%S+')

    if path then
        hs.execute('/usr/local/bin/smerge "' .. path .. '"')
    end
end)

hs.urlevent.bind('misc-openInAtom', function()
    if appIs(iterm) then
        typeAndEnter('atom .')
    else
        triggerAlfredWorkflow('projects', 'com.fuelingtheweb.commands')
    end
end)

hs.urlevent.bind('misc-openInChrome', function()
    text = getSelectedText()
    if not appIncludes({atom, sublime}) and text then
        runGoogleSearch(text)
    elseif appIs(chrome) then
        copyChromeUrl()
        openInChrome(getSelectedText())
    else
        ProjectManager.openUrlForCurrent()
    end
end)

hs.urlevent.bind('misc-openInTablePlus', function()
    customOpenInTablePlus()
end)

hs.urlevent.bind('misc-openInFinder', function()
    if appIs(iterm) then
        typeAndEnter('o.')
    else
        path = currentTitle():match('~%S+')
        if not path then
           return;
        end
        if appIs(atom) then
            hs.execute('open ' .. path)
        else
            hs.execute('open -R ' .. path)
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

hs.urlevent.bind('google-toggleIncognito', function()
    if customUpdateChromeUrl() then
        return;
    end

    hs.osascript.applescript([[
        tell application "Google Chrome"
            set theUrl to URL of active tab of front window
            set theMode to mode of front window
        end tell

        if theMode is equal to "normal" then
            do shell script "'/Applications/Google Chrome.app/Contents/MacOS/Google Chrome' --incognito --profile-directory='Default' " & quoted form of theUrl
        else
            do shell script "'/Applications/Google Chrome.app/Contents/MacOS/Google Chrome' --profile-directory='Default' " & quoted form of theUrl
        end if
    ]])
end)

hs.urlevent.bind('misc-saveAndReload', function()
    hs.eventtap.keyStroke({'cmd'}, 'S')
    hs.application.get(apps['chrome']):activate()
    hs.eventtap.keyStroke({'cmd'}, 'R')
end)

hs.urlevent.bind('misc-uppercase', function()
    hs.eventtap.keyStroke({'shift', 'alt'}, 'left', 0)
    hs.eventtap.keyStrokes(getSelectedText():upper(), 0)
end)

hs.urlevent.bind('misc-moveMouseToOtherScreen', function()
    hs.mouse.setAbsolutePosition(
        hs.geometry.rectMidPoint(hs.mouse.getCurrentScreen():next():fullFrame())
    )
end)

return obj
