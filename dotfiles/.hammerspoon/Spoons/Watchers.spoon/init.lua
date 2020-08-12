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

windowsForCreatedHook:subscribe(wf.windowCreated, function (window)
    if window:subrole() == 'AXDialog' then
        return
    end

    if appIncludes({sublime, notion, atom, chrome}) then
        window:maximize()
    elseif appIs(discord) then
        hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 'H')
    -- elseif appIs(teams) then
    --     if isMacbookDisplay() then
    --         hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 'F')
    --     else
    --         hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 'L')
    --     end
    elseif appIs(finder) then
        hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 'J')
    end
end)

allwindows:subscribe(wf.windowDestroyed, function (window, appName, reason)
    app = hs.application.frontmostApplication()
    count = 0
    for k,v in pairs(app:visibleWindows()) do
        if (appIs(preview) or appIs(finder)) and v:title() == '' then
        else
            count = count + 1
        end
    end
    if count < 1 then
        if appIs(preview) then
            app:kill()
        else
            app:hide()
        end
    end
end)

gokuWatcher = hs.pathwatcher.new(os.getenv('HOME') .. '/.fuelingzsh/karabiner/goku/', function ()
    output = hs.execute(os.getenv('HOME') .. '/.fuelingzsh/karabiner/goku.sh')
    hs.notify.new({title = 'Goku Config', informativeText = output}):send()
end):start()
karabinerWatcher = hs.pathwatcher.new(os.getenv('HOME') .. '/.config/karabiner.edn/', function ()
    output = hs.execute('/usr/local/bin/goku')
    hs.notify.new({title = 'Karabiner Config', informativeText = output}):send()
end):start()

return obj
