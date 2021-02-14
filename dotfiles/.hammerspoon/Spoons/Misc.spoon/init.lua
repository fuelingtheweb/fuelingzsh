local obj = {}
obj.__index = obj

hs.urlevent.bind('command-closeAllWindows', function()
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

hs.urlevent.bind('pane-destroy', function()
    if appIs(sublime) then
        hs.eventtap.keyStrokes(':ods')
    elseif appIs(iterm) then
        hs.eventtap.keyStroke({'cmd',}, 'w')
    end
end)

hs.urlevent.bind('pane-focusPrevious', function()
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

hs.urlevent.bind('pane-focusNext', function()
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

hs.urlevent.bind('window-toggleSidebar', function()
    if appIs(finder) then
        hs.eventtap.keyStroke({'alt', 'cmd'}, 's')
    elseif appIs(sublimeMerge) then
        hs.eventtap.keyStroke({'cmd'}, 'K')
        hs.eventtap.keyStroke({'cmd'}, 'B')
    else
        hs.eventtap.keyStroke({'cmd'}, '\\')
    end
end)

hs.urlevent.bind('command-surroundText', function()
    hs.eventtap.keyStroke({'cmd'}, 'C')
    triggerAlfredWorkflow('surround', 'com.fuelingtheweb.commands')
end)

hs.urlevent.bind('search-tabs', function()
    if appIs(atom) then
        hs.eventtap.keyStroke({'cmd'}, 'b')
    elseif appIs(sublime) then
        hs.eventtap.keyStroke({'alt', 'shift'}, 'p')
    elseif appIs(chrome) then
        hs.eventtap.keyStrokes('T')
    end
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

hs.urlevent.bind('command-saveAndReload', function()
    hs.eventtap.keyStroke({'cmd'}, 'S')
    hs.application.get(apps['chrome']):activate()
    hs.eventtap.keyStroke({'cmd'}, 'R')
end)

hs.urlevent.bind('misc-moveMouseToOtherScreen', function()
    hs.mouse.setAbsolutePosition(
        hs.geometry.rectMidPoint(hs.mouse.getCurrentScreen():next():fullFrame())
    )
end)

hs.urlevent.bind('window-appSettings', function()
    if isAlfredVisible() then
        hs.application.open('com.runningwithcrayons.Alfred-Preferences')
    else
        hs.eventtap.keyStroke({'cmd'}, ',')
    end
end)

return obj
