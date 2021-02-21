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
    if appIncludes({atom, sublime}) then
        hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 'p', 0)
        hs.eventtap.keyStroke({}, 'o', 0)
        hs.eventtap.keyStroke({}, 'd', 0)
        hs.eventtap.keyStroke({}, 's', 0)
    elseif appIs(iterm) then
        hs.eventtap.keyStroke({'cmd'}, 'w', 0)
    end
end)

hs.urlevent.bind('pane-splitRight', function()
    if appIncludes({atom, sublime}) then
        hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 'p', 0)
        hs.eventtap.keyStroke({}, 'o', 0)
        hs.eventtap.keyStroke({}, 'c', 0)
        hs.eventtap.keyStroke({}, 'l', 0)
    elseif appIs(iterm) then
        hs.eventtap.keyStroke({'cmd'}, 'd', 0)
    end
end)

hs.urlevent.bind('pane-splitBottom', function()
    if appIncludes({atom, sublime}) then
        hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 'p', 0)
        hs.eventtap.keyStroke({}, 'o', 0)
        hs.eventtap.keyStroke({}, 'c', 0)
        hs.eventtap.keyStroke({}, 'j', 0)
    end
end)

hs.urlevent.bind('pane-toggleZoom', function()
    if appIncludes({atom, sublime}) then
        hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 'p', 0)
        hs.eventtap.keyStroke({}, 'o', 0)
        hs.eventtap.keyStroke({}, 'z', 0)
    elseif appIs(iterm) then
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'return', 0)
    end
end)

hs.urlevent.bind('pane-focusPrevious', function()
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
end)

hs.urlevent.bind('pane-focusNext', function()
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

hs.urlevent.bind('search-default', function()
    if inCodeEditor() then
        TextManipulation.disableVim()
        hs.eventtap.keyStroke({}, '/', 0)
    end
end)

hs.urlevent.bind('search-tabs', function()
    if appIs(atom) then
        hs.eventtap.keyStroke({'cmd'}, 'b')
    elseif appIs(sublime) then
        hs.eventtap.keyStroke({'alt', 'shift'}, 'p')
    elseif appIs(chrome) then
        hs.eventtap.keyStroke({'shift'}, 't')
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

hs.urlevent.bind('misc-optionPressedOnce', function()
    if appIs(spotify) then
        hs.execute('open -g "hammerspoon://window-next"')
    else
        hs.execute('open -g "hammerspoon://media-showVideoBar"')
    end
end)

hs.urlevent.bind('misc-optionPressedTwice', function()
    app = hs.application.get(spotify)

    if app and app:isRunning() then
        app:activate()
    end
end)

return obj
