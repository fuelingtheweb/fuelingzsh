local ExtendedCommandMode = {}
ExtendedCommandMode.__index = ExtendedCommandMode

ExtendedCommandMode.lookup = {
    tab = nil,
    q = nil,
    w = 'surroundText',
    e = 'undo',
    r = 'redo',
    t = nil,
    caps_lock = 'dismissNotifications',
    a = 'actionFileInAlfred',
    s = 'screenshotToFilesystem',
    d = 'duplicate',
    f = 'revealInSidebar',
    g = 'toggleDockVisibility',
    left_shift = nil,
    z = nil,
    x = nil,
    c = 'screenshotToClipboard',
    v = nil,
    b = 'showBartender',
    spacebar = 'newWindowOrFolder',
}

function ExtendedCommandMode.redo()
    fastKeyStroke({'shift', 'cmd'}, 'z')
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

function ExtendedCommandMode.undo()
    fastKeyStroke({'cmd'}, 'z')
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

return ExtendedCommandMode
