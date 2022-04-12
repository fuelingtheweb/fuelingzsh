local ExtendedCommand = {}
ExtendedCommand.__index = ExtendedCommand

ExtendedCommand.lookup = {
    tab = 'enableRunOnSave',
    q = nil,
    w = nil,
    -- w = 'surroundText',
    e = nil,
    r = 'reloadSecondary',
    t = nil,
    caps_lock = fn.misc.DismissNotifications.run,
    a = fn.Alfred.open,
    s = 'screenshotToFilesystem',
    d = nil,
    f = 'revealInSidebar',
    g = 'saveAndReload',
    left_shift = 'disableRunOnSave',
    z = fn.Alfred.sleep,
    x = fn.Alfred.emptyTrash,
    c = 'screenshotToClipboard',
    v = 'toggleDockVisibility',
    b = 'showBartender',
    spacebar = 'newWindowOrFolder',
}

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

function ExtendedCommand.enableRunOnSave()
    ks.super('f').super('e')
end

function ExtendedCommand.disableRunOnSave()
    ks.super('f').super('d')
end

return ExtendedCommand
