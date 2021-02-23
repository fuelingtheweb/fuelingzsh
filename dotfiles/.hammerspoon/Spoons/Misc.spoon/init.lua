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
