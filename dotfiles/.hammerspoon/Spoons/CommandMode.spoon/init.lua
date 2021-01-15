local obj = {}
obj.__index = obj

hs.urlevent.bind('command-newTab', function()
    if appIncludes({sublime, atom, finder}) then
        hs.eventtap.keyStroke({'cmd'}, 'n')
    else
        hs.eventtap.keyStroke({'cmd'}, 't')
    end
end)

hs.urlevent.bind('command-reload', function()
    if appIs(atom) then
        hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 'r')
    elseif appIs(postman) then
        hs.eventtap.keyStroke({'cmd'}, 'return')
    elseif appIs(iterm) then
        hs.eventtap.keyStroke({'ctrl'}, 'c')
        hs.eventtap.keyStroke({}, 'up')
        hs.eventtap.keyStroke({}, 'return')
    else
        hs.eventtap.keyStroke({'cmd'}, 'r')
    end
end)

hs.urlevent.bind('command-closeWindow', function()
    hs.eventtap.keyStroke({'cmd'}, 'W')
    if appIs(chrome) then
        hs.timer.doAfter(1, function()
            app = hs.application.frontmostApplication()
            if next(app:visibleWindows()) == nil then
                app:hide()
            end
        end)
    end
end)

hs.urlevent.bind('command-find', function()
    if appIncludes({atom, sublime}) then
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'f')
    else
        hs.eventtap.keyStroke({'cmd'}, 'f')
    end
end)

hs.urlevent.bind('command-done', function()
    if appIs(notion) then
        hs.eventtap.keyStroke({'cmd'}, 'return')
    elseif appIs(sublime) then
        -- Edit with: Done
        hs.eventtap.keyStroke({'shift', 'ctrl', 'alt', 'cmd'}, 'd')
    elseif appIs(transmit) then
        -- Disconnect from server
        hs.eventtap.keyStroke({'cmd'}, 'e')
    else
        hs.eventtap.keyStroke({'cmd'}, 'return')
    end
end)

hs.urlevent.bind('command-save', function()
    if appIs(chrome) then
        -- Save to Raindrop
        hs.eventtap.keyStroke({'shift', 'cmd'}, 's')
    elseif appIs(iterm) then
        -- Save from Vim
        hs.eventtap.keyStroke({'shift'}, ';')
        hs.eventtap.keyStroke({}, 'x')
        hs.eventtap.keyStroke({}, 'return')
    else
        hs.eventtap.keyStroke({'cmd'}, 's')
    end
end)

hs.urlevent.bind('command-dismissNotifications', function()
    app = hs.application.frontmostApplication()
    each({1,2,3}, function ()
        hs.osascript.applescript([[
            activate application "NotificationCenter"
            tell application "System Events"
                tell process "Notification Center"
                    set theWindow to group 1 of UI element 1 of scroll area 1 of window "Notification Center"
                    click theWindow
                    set theActions to actions of theWindow
                    repeat with theAction in theActions
                        if description of theAction is "Close" then
                            tell theWindow
                                perform theAction
                            end tell
                        end if
                    end repeat
                end tell
            end tell
        ]])
    end)
    app:activate()
end)

hs.urlevent.bind('command-cancelOrDelete', function()
    text = getSelectedText()
    if appIncludes({atom, sublime}) then
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'delete')
    elseif appIs(finder) and text == 'finderFileSelected' then
        hs.eventtap.keyStroke({'cmd'}, 'delete')
    elseif appIs(transmit) then
        hs.eventtap.keyStroke({'cmd'}, 'delete')
    elseif text then
        hs.eventtap.keyStroke({}, 'delete')
    elseif appIs(chrome) and stringContains('Fueling the Web Mail', currentTitle()) then
        hs.eventtap.keyStroke({'shift'}, '3')
    elseif appIs(iterm) then
        hs.eventtap.keyStroke({'ctrl'}, 'C')
    else
        hs.eventtap.keyStroke({}, 'delete')
    end
end)

return obj
