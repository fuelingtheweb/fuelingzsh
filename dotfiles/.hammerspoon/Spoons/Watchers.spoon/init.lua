local obj = {}
obj.__index = obj

hs.screen.watcher.new(function()
    if hs.screen.primaryScreen():name() == 'LG ULTRAWIDE' then
        hs.audiodevice.findOutputByName('Built-in Output'):setDefaultOutputDevice()
    end
end):start()

local wf = hs.window.filter
local allwindows = wf.new(nil)
allwindows:rejectApp('Hammerspoon'):rejectApp('Alfred'):rejectApp('Shortcat')
hs.window.animationDuration = 0

allwindows:subscribe(wf.windowDestroyed, function(window, appName, reason)
    local app = window:application()
    local bundle = app:bundleID()
    local count = 0

    for k, v in pairs(app:visibleWindows()) do
        if fn.table.has({preview, finder}, bundle) and v:title() == '' then
        else
            count = count + 1
        end
    end

    if count < 1 then
        if fn.table.has({preview, sublimeMerge, slack, vscode, spotify, tableplus, zoom, rayapp, transmit}, bundle) then
            app:kill()
        elseif app:isFrontmost() then
            app:hide()
        end
    end

    cm.Window.focusFirst(
        cm.Window.filtered(cm.Window.currentScreen())
    )
end)

gokuWatcher = hs.pathwatcher.new(os.getenv('HOME') .. '/.fuelingzsh/karabiner/goku/', function(paths)
    local shouldRun = true

    fn.each(paths, function(path)
        if str.contains('.pyc', path) then
            shouldRun = false
        end
    end)

    if shouldRun then
        local output = hs.execute(os.getenv('HOME') .. '/.fuelingzsh/karabiner/goku.sh')
        hs.notify.new({title = 'Goku Config', informativeText = output}):send()
    end
end)

karabinerWatcher = hs.pathwatcher.new(os.getenv('HOME') .. '/.config/karabiner.edn/', function()
    local output = hs.execute('/usr/local/bin/goku')

    hs.notify.new({title = 'Karabiner Config', informativeText = output}):send()
end)

gokuWatcher:start()
karabinerWatcher:start()

return obj
