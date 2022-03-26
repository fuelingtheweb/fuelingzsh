local obj = {}
obj.__index = obj

hs.screen.watcher.new(function()
    if isDisplay(ultrawide) then
        hs.audiodevice.findOutputByName('Built-in Output'):setDefaultOutputDevice()
    end
end):start()

wf = hs.window.filter
windowsForCreatedHook = wf.new{'Sublime Text', 'Notion', 'Atom', 'Google Chrome', 'Discord', 'Microsoft Teams', 'Finder'}
allwindows = wf.new(nil)
allwindows:rejectApp('Hammerspoon'):rejectApp('Alfred'):rejectApp('Shortcat')
hs.window.animationDuration = 0

openWindows = {}

function windowCreated(window)
    if window:subrole() == 'AXDialog' then
        return
    end

    if appIs(chrome) then
        windowsForCreatedHook:pause()
        window:application():hide()
        window:focus()
        hs.timer.doAfter(1, function()
            log.d('Listen again')
            windowsForCreatedHook:resume()
        end)
    end

    if appIncludes({sublime, notion, atom, chrome}) then
        window:maximize()
    elseif appIs(discord) then
        ks.super('h')
    elseif appIs(teams) then
        if isMacbookDisplay() then
            ks.super('f')
        else
            ks.super('l')
        end
    elseif appIs(finder) then
        ks.super('j')
    end
end

-- windowsForCreatedHook:subscribe(wf.windowCreated, windowCreated)

allwindows:subscribe(wf.windowDestroyed, function (window, appName, reason)
    app = hs.application.frontmostApplication()
    count = 0
    for k,v in pairs(app:visibleWindows()) do
        if (appIs(preview) or appIs(finder)) and v:title() == '' then
        else
            count = count + 1
        end
    end
    if count < 1 and app:isFrontmost() then
        if appIs(preview) then
            app:kill()
        else
            app:hide()
        end
    end

    if not (window:application():bundleID() == chrome and stringContains("Untitled %- Google Chrome", window:title())) then
        for key, value in pairs(openWindows) do
            if window:id() == value then
                table.remove(openWindows, key)
            end
        end
    end
end)

gokuWatcher = hs.pathwatcher.new(os.getenv('HOME') .. '/.fuelingzsh/karabiner/goku/', function (paths)
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

karabinerWatcher = hs.pathwatcher.new(os.getenv('HOME') .. '/.config/karabiner.edn/', function ()
    output = hs.execute('/usr/local/bin/goku')
    hs.notify.new({title = 'Karabiner Config', informativeText = output}):send()
end)

gokuWatcher:start()
karabinerWatcher:start()

return obj
