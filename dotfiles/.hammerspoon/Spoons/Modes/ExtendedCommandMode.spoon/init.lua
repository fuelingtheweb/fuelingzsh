local ExtendedCommandMode = {}
ExtendedCommandMode.__index = ExtendedCommandMode

ExtendedCommandMode.lookup = {
    tab = nil,
    q = nil,
    w = 'closeAllWindows',
    -- w = 'surroundText',
    e = nil,
    r = 'reloadSecondary',
    t = 'enableScrolling',
    caps_lock = 'jumpTo',
    -- caps_lock = 'dismissNotifications',
    a = 'actionFileInAlfred',
    s = 'screenshotToFilesystem',
    d = 'duplicate',
    f = 'revealInSidebar',
    g = 'saveAndReload',
    left_shift = nil,
    z = 'sleep',
    x = 'searchFiles',
    c = 'screenshotToClipboard',
    v = 'toggleDockVisibility',
    b = 'showBartender',
    spacebar = 'newWindowOrFolder',
}

function ExtendedCommandMode.searchFiles()
    spoon.SearchMode.files()
end

function ExtendedCommandMode.sleep()
    triggerAlfredSearch('sleep')
end

function ExtendedCommandMode.actionFileInAlfred()
    fastKeyStroke({'alt', 'cmd'}, '\\')
end

function ExtendedCommandMode.screenshotToFilesystem()
    fastKeyStroke({'shift', 'cmd'}, '4')
end

function ExtendedCommandMode.revealInSidebar()
    -- Atom: Reveal active file in tree view
    fastKeyStroke({'shift', 'cmd'}, '\\')
end

function ExtendedCommandMode.toggleDockVisibility()
    fastKeyStroke({'alt', 'cmd'}, 'd')
end

function ExtendedCommandMode.screenshotToClipboard()
    fastKeyStroke({'shift', 'ctrl', 'cmd'}, '4')
end

function ExtendedCommandMode.showBartender()
    fastKeyStroke({'shift', 'ctrl', 'cmd'}, 'b')
end

function ExtendedCommandMode.newWindowOrFolder()
    fastKeyStroke({'shift', 'cmd'}, 'n')
end

function ExtendedCommandMode.dismissNotifications()
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
end

function ExtendedCommandMode.duplicate()
    if appIs(finder) then
        fastKeyStroke({'cmd'}, 'd')
    elseif appIs(chrome) then
        -- Vimium
        fastKeyStroke('escape')
        insertText('yt')
    elseif inCodeEditor() then
        fastKeyStroke({'shift', 'alt', 'cmd'}, 'd')
    end
end

function ExtendedCommandMode.surroundText()
    fastKeyStroke({'cmd'}, 'c')
    triggerAlfredWorkflow('surround', 'com.fuelingtheweb.commands')
end

function ExtendedCommandMode.closeAllWindows()
    fastKeyStroke({'shift', 'cmd'}, 'w')
    if appIs(chrome) then
        hs.timer.doAfter(1, function()
            app = hs.application.frontmostApplication()
            if next(app:visibleWindows()) == nil then
                app:hide()
            end
        end)
    end
end

function ExtendedCommandMode.reloadSecondary()
    if appIs(chrome) then
        -- Hard refresh
        fastKeyStroke({'shift', 'cmd'}, 'r')
    elseif appIs(iterm) then
        -- Reload running command
        fastKeyStroke({'ctrl'}, 'c')
        fastKeyStroke('up')
        fastKeyStroke('return')
    end
end

function ExtendedCommandMode.saveAndReload()
    fastKeyStroke('escape')
    keyStroke({'cmd'}, 's')
    hs.application.get(apps['chrome']):activate()
    keyStroke({'cmd'}, 'r')
end

function ExtendedCommandMode.jumpTo()
    if appIs(atom) then
        fastKeyStroke({'shift'}, 'return')
    elseif appIs(sublime) then
        fastKeyStroke({'shift', 'cmd'}, '.')
    else
        fastKeyStroke({'ctrl'}, 'space')
    end
end

function ExtendedCommandMode.enableScrolling()
    -- Vimac: Enable Scroll
    fastKeyStroke({'ctrl', 'alt', 'cmd'}, 's')
end

return ExtendedCommandMode
