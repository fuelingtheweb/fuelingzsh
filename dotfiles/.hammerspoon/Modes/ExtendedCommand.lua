local ExtendedCommand = {}
ExtendedCommand.__index = ExtendedCommand

ExtendedCommand.lookup = {
    tab = 'enableRunOnSave',
    q = nil,
    w = fn.custom.openTasks,
    -- w = 'surroundText',
    e = 'espansoSearch',
    -- r = 'reloadSecondary',
    r = fn.custom.openClientProject,
    t = nil,
    caps_lock = fn.Alfred.open,
    a = nil,
    s = 'screenshotToFilesystem',
    d = fn.custom.openHammerspoonConfig,
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

local runOnSaveDisabled = false

function ExtendedCommand.disableRunOnSave()
    if runOnSaveDisabled then
        runOnSaveDisabled = false

        ks.super('f').super('e')
    else
        runOnSaveDisabled = true

        ks.super('f').super('d')
    end
end

function ExtendedCommand.espansoSearch()
    ks.shiftAlt('space')
end

return ExtendedCommand
