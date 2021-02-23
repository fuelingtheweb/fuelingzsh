hs.loadSpoon('Variables')
hs.loadSpoon('Functions')
hs.loadSpoon('Watchers')
hs.loadSpoon('CommandMode')
hs.loadSpoon('LaunchMode')
hs.loadSpoon('OpenMode')
hs.loadSpoon('SnippetMode')
hs.loadSpoon('MediaMode')
TextManipulation = hs.loadSpoon('TextManipulation')
hs.loadSpoon('Misc')
hs.loadSpoon('KarabinerHandler')

-- VimMode = hs.loadSpoon('VimMode')
-- vim = VimMode:new()

-- vim:bindHotKeys({enter = {{'cmd', 'shift'}, 'v'}})

hs.loadSpoon('Custom')

hs.loadSpoon('MouseCircle')
spoon.MouseCircle.color = {hex = '#367f71'}
spoon.MouseCircle:bindHotkeys({show = {{'ctrl', 'alt', 'cmd'}, 'M'}})

hs.loadSpoon('ReloadConfiguration')
spoon.ReloadConfiguration.watch_paths = {hs.configdir, hs.configdir .. '/Spoons/Custom.spoon'}
spoon.ReloadConfiguration:start()
hs.notify.new({title = 'Hammerspoon', informativeText = 'Config loaded'}):send()

hs.hotkey.bind({'cmd', 'alt', 'ctrl'}, 'B', function()
    app = hs.application.frontmostApplication()
    bundle = app:bundleID()
    hs.pasteboard.setContents(bundle)
    hs.notify.new({title = 'App Bundle Copied', informativeText = bundle}):send()
end)
