local ExtendedCommand = {}
ExtendedCommand.__index = ExtendedCommand

ExtendedCommand.lookup = {
    tab = 'toggleUseIgnoreFiles',
    q = nil,
    w = nil,
    e = nil,
    r = fn.custom.openClientProject,
    t = nil,
    caps_lock = fn.custom.openTasks,
    a = nil,
    s = nil,
    d = fn.custom.openHammerspoonConfig,
    f = 'revealInSidebar',
    g = 'saveAndReload',
    left_shift = 'toggleRunOnSave',
    z = nil,
    x = 'screenshotToFilesystem',
    c = 'screenshotToClipboard',
    v = nil,
    b = nil,
    spacebar = nil,
}

function ExtendedCommand.screenshotToFilesystem()
    ks.shiftCmd('4')
end

function ExtendedCommand.revealInSidebar()
    ks.shiftCmd('\\')
end

function ExtendedCommand.screenshotToClipboard()
    ks.shiftCtrlCmd('4')
end

function ExtendedCommand.saveAndReload()
    ks.escape().slow().save()
    hs.application.get(chrome):activate()
    ks.slow().refresh()
end

local runOnSaveDisabled = false

function ExtendedCommand.toggleRunOnSave()
    if runOnSaveDisabled then
        runOnSaveDisabled = false

        ks.super('f').super('e')
    else
        runOnSaveDisabled = true

        ks.super('f').super('d')
    end

    hs.notify.new({
        title = runOnSaveDisabled and 'Disabled' or 'Enabled',
        informativeText = 'Run on Save'
    }):send()
end

local useIgnoreFilesEnabled = true

function ExtendedCommand.toggleUseIgnoreFiles()
    ks.shiftCtrl('t')
    useIgnoreFilesEnabled = not useIgnoreFilesEnabled

    hs.notify.new({
        title = useIgnoreFilesEnabled and 'Enabled' or 'Disabled',
        informativeText = 'Search: Use Ignore Files'
    }):send()
end

return ExtendedCommand
