local obj = {}
obj.__index = obj

hs.urlevent.bind('misc-optionPressedOnce', function()
    if appIs(spotify) then
        spoon.WindowManager.next()
    else
        spoon.MediaMode.showVideoBar()
    end
end)

hs.urlevent.bind('misc-optionPressedTwice', function()
    app = hs.application.get(spotify)

    if app and app:isRunning() then
        app:activate()
    end
end)

UrlDispatcher = hs.loadSpoon('vendor/URLDispatcher')
UrlDispatcher.default_handler = chrome
UrlDispatcher.url_patterns = dofile(hs.configdir .. '/config/custom/routing.lua')
UrlDispatcher:start()

Shortcuts = hs.loadSpoon('Shortcuts')
Shortcuts:addFromConfig()
Shortcuts:listen()

ProjectManager = hs.loadSpoon('ProjectManager')
ProjectManager:addFromConfig()
ProjectManager:setAlfredJson()

AlfredCommands = hs.loadSpoon('AlfredCommands')
AlfredCommands:addFromConfig()
AlfredCommands:listen()
AlfredCommands:setAlfredJson()

dofile(hs.configdir .. '/config/custom/open.lua')

spoon.MouseCircle = hs.loadSpoon('vendor/MouseCircle')
spoon.MouseCircle.color = {hex = '#367f71'}
spoon.MouseCircle:bindHotkeys({show = {{'ctrl', 'alt', 'cmd'}, 'M'}})

spoon.ReloadConfiguration = hs.loadSpoon('vendor/ReloadConfiguration')
spoon.ReloadConfiguration.watch_paths = {
    hs.configdir,
    hs.configdir .. '/Spoons/Custom.spoon',
    hs.configdir .. '/config/custom',
}
spoon.ReloadConfiguration:start()
hs.notify.new({title = 'Hammerspoon', informativeText = 'Config loaded'}):send()

hs.hotkey.bind({'cmd', 'alt', 'ctrl'}, 'B', function()
    app = hs.application.frontmostApplication()
    bundle = app:bundleID()
    hs.pasteboard.setContents(bundle)
    hs.notify.new({title = 'App Bundle Copied', informativeText = bundle}):send()
end)

return obj
