local obj = {}
obj.__index = obj

hs.urlevent.bind('command-newTab', function()
    if appIs(sublime) or appIs(atom) then
        hs.eventtap.keyStroke({'cmd'}, 'n')
    else
        hs.eventtap.keyStroke({'cmd'}, 't')
    end
end)

hs.urlevent.bind('command-reload', function()
    if appIs(atom) then
        hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 'r')
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
    hs.osascript.applescript([[
        tell application "System Events"
            tell process "Notification Center"
                set theseWindows to every window whose subrole is "AXNotificationCenterAlert" or subrole is "AXNotificationCenterBanner"
                repeat with i from 1 to number of items in theseWindows
                    set this_item to item i of theseWindows
                    try
                        click button 1 of this_item
                    end try
                end repeat
            end tell
        end tell
    ]])
end)

hs.urlevent.bind('command-cancelOrDelete', function()
    text = getSelectedText()
    if appIs(atom) then
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'delete')
    elseif appIs(finder) and text == 'finderFileSelected' then
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
