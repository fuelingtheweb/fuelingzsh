local obj = {}
obj.__index = obj

hs.screen.watcher.new(function()
    if hs.screen.primaryScreen():name() == 'LG ULTRAWIDE' then
        hs.audiodevice.findOutputByName('Built-in Output'):setDefaultOutputDevice()
    end
end):start()

wf = hs.window.filter
allwindows = wf.new(nil)
allwindows:rejectApp('Hammerspoon'):rejectApp('Alfred'):rejectApp('Shortcat')
hs.window.animationDuration = 0

allwindows:subscribe(wf.windowDestroyed, function(window, appName, reason)
    local app = window:application()
    local bundle = app:bundleID()
    local count = 0

    for k, v in pairs(app:visibleWindows()) do
        if hasValue({preview, finder}, bundle) and v:title() == '' then
        else
            count = count + 1
        end
    end

    if count < 1 then
        if hasValue({preview, sublimeMerge, slack, discord, sublime, vscode, spotify, tableplus, zoom, rayapp}, bundle) then
            app:kill()
        elseif app:isFrontmost() then
            app:hide()
        end
    end
end)

gokuWatcher = hs.pathwatcher.new(os.getenv('HOME') .. '/.fuelingzsh/karabiner/goku/', function(paths)
    shouldRun = true
    each(paths, function(path)
        if stringContains('.pyc', path) then
            shouldRun = false
        end
    end)

    if shouldRun then
        output = hs.execute(os.getenv('HOME') .. '/.fuelingzsh/karabiner/goku.sh')
        hs.notify.new({title = 'Goku Config', informativeText = output}):send()
    end
end)

karabinerWatcher = hs.pathwatcher.new(os.getenv('HOME') .. '/.config/karabiner.edn/', function()
    output = hs.execute('/usr/local/bin/goku')
    hs.notify.new({title = 'Karabiner Config', informativeText = output}):send()
end)

gokuWatcher:start()
karabinerWatcher:start()

return obj
