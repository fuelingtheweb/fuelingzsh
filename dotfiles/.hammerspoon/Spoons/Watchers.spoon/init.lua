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
    app = hs.application.frontmostApplication()
    count = 0

    for k, v in pairs(app:visibleWindows()) do
        if (is.In(preview) or is.finder()) and v:title() == '' then
        else
            count = count + 1
        end
    end

    if count < 1 and app:isFrontmost() then
        if is.In(preview) then
            app:kill()
        else
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
