local ExtendedCommandMode = {}
ExtendedCommandMode.__index = ExtendedCommandMode

function ExtendedCommandMode.tab()
end

function ExtendedCommandMode.q()
end

function ExtendedCommandMode.w()
    ExtendedCommandMode.surroundText()
end

function ExtendedCommandMode.e()
end

function ExtendedCommandMode.r()
    -- Redo
    fastKeyStroke({'shift', 'cmd'}, 'z')
end

function ExtendedCommandMode.t()
end

function ExtendedCommandMode.caps_lock()
    ExtendedCommandMode.dismissNotifications()
end

function ExtendedCommandMode.a()
    -- Alfred: Action File
    fastKeyStroke({'alt', 'cmd'}, '\\')
end

function ExtendedCommandMode.s()
    -- Screenshot to filesystem
    fastKeyStroke({'shift', 'cmd'}, '4')
end

function ExtendedCommandMode.d()
    ExtendedCommandMode.duplicate()
end

function ExtendedCommandMode.f()
    -- Atom: Reveal active file in tree view
    fastKeyStroke({'shift', 'cmd'}, '\\')
end

function ExtendedCommandMode.g()
    -- Toggle dock visibility
    fastKeyStroke({'alt', 'cmd'}, 'd')
end

function ExtendedCommandMode.left_shift()
end

function ExtendedCommandMode.z()
    -- Undo
    fastKeyStroke({'cmd'}, 'z')
end

function ExtendedCommandMode.x()
end

function ExtendedCommandMode.c()
    -- Screenshot to clipboard
    fastKeyStroke({'shift', 'ctrl', 'cmd'}, '4')
end

function ExtendedCommandMode.v()
end

function ExtendedCommandMode.b()
    -- Bartender: Show
    fastKeyStroke({'shift', 'ctrl', 'cmd'}, 'b')
end

function ExtendedCommandMode.spacebar()
    -- New window / folder
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
