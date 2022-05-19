local obj = {}
obj.__index = obj

log = hs.logger.new('ftw-log', 'debug')

hs.urlevent.bind('misc-optionPressedOnce', function()
    if is.In(spotify) then
        cm.Window.next()
    else
        md.Media.showVideoBar()
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
UrlDispatcher.url_patterns = require('config.custom.routing')
UrlDispatcher:start()

Shortcuts = hs.loadSpoon('Shortcuts')
Shortcuts:addFromConfig()

ProjectManager = hs.loadSpoon('ProjectManager')
ProjectManager:addFromConfig()
ProjectManager:setAlfredJson()

AlfredCommands = hs.loadSpoon('AlfredCommands')
AlfredCommands:addFromConfig()
AlfredCommands:listen()
AlfredCommands:setAlfredJson()

spoon.MouseCircle = hs.loadSpoon('vendor/MouseCircle')
spoon.MouseCircle.color = {hex = '#367f71'}

spoon.ReloadConfiguration = hs.loadSpoon('vendor/ReloadConfiguration')
spoon.ReloadConfiguration.watch_paths = {
    hs.configdir,
    hs.configdir .. '/Spoons/Custom.spoon',
    hs.configdir .. '/config/custom',
}
spoon.ReloadConfiguration:start()
hs.notify.new({title = 'Hammerspoon', informativeText = 'Config loaded'}):send()

hs.hotkey.bind({'cmd', 'alt', 'ctrl'}, 'B', function()
    local app = hs.application.frontmostApplication()
    local bundle = app:bundleID()

    fn.clipboard.set(bundle)
    hs.notify.new({title = 'App Bundle Copied', informativeText = bundle}):send()
end)

hs.hotkey.bind({'cmd', 'alt', 'ctrl'}, 'space', function()
    local title = fn.window.title()

    hs.alert.show(title)
    fn.clipboard.set(title)
end)

hs.hotkey.bind({'cmd', 'alt', 'ctrl'}, 'm', function()
    local position = hs.mouse.getAbsolutePosition()
    local title = 'x: ' .. position.x .. ' y: ' .. position.y

    hs.alert.show(title)
    fn.clipboard.set(title)

    spoon.MouseCircle:show()
end)

return obj
