local ExtendedCommand = {}
ExtendedCommand.__index = ExtendedCommand

ExtendedCommand.lookup = {
    tab = 'enableRunOnSave',
    q = nil,
    w = nil,
    -- w = 'surroundText',
    e = nil,
    r = 'reloadSecondary',
    t = 'enableScrolling',
    caps_lock = 'jumpTo',
    -- caps_lock = 'dismissNotifications',
    a = nil,
    s = 'screenshotToFilesystem',
    d = nil,
    f = 'revealInSidebar',
    g = 'saveAndReload',
    left_shift = 'disableRunOnSave',
    z = 'sleep',
    x = nil,
    c = 'screenshotToClipboard',
    v = 'toggleDockVisibility',
    b = 'showBartender',
    spacebar = 'newWindowOrFolder',
}

function ExtendedCommand.sleep()
    fn.Alfred.search('sleep')
end

function ExtendedCommand.screenshotToFilesystem()
    ks.shiftCmd('4')
end

function ExtendedCommand.revealInSidebar()
    ks.shiftCmd('\\')
end

function ExtendedCommand.toggleDockVisibility()
    ks.altCmd('d')
end

function ExtendedCommand.screenshotToClipboard()
    ks.shiftCtrlCmd('4')
end

function ExtendedCommand.showBartender()
    ks.shiftCtrlCmd('b')
end

function ExtendedCommand.newWindowOrFolder()
    ks.shiftCmd('n')
end

function ExtendedCommand.dismissNotifications()
    app = hs.application.frontmostApplication()

    each({1, 2, 3}, function()
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

function ExtendedCommand.surroundText()
    ks.copy()
    fn.Alfred.run('surround', 'com.fuelingtheweb.commands')
end

function ExtendedCommand.reloadSecondary()
    if is.chrome() then
        -- Hard refresh
        ks.shiftCmd('r')
    elseif is.iterm() then
        -- Reload running command
        ks.ctrl('c').up().enter()
    end
end

function ExtendedCommand.saveAndReload()
    ks.escape().slow().save()
    hs.application.get(chrome):activate()
    ks.slow().refresh()
end

function ExtendedCommand.jumpTo()
    if is.vscode() then
        ks.super('return')
    elseif is.In(atom) then
        ks.shift('return')
    elseif is.sublime() then
        ks.shiftCmd('.')
    else
        ks.ctrl('space')
    end
end

function ExtendedCommand.enableScrolling()
    -- Vimac: Enable Scroll
    ks.super('s')
end

function ExtendedCommand.enableRunOnSave()
    ks.super('f').super('e')
end

function ExtendedCommand.disableRunOnSave()
    ks.super('f').super('d')
end

return ExtendedCommand
