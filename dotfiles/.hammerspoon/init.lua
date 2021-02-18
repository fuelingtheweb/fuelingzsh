hs.loadSpoon('Variables')
hs.loadSpoon('Functions')
hs.loadSpoon('Watchers')
hs.loadSpoon('HyperMode')
hs.loadSpoon('CommandMode')
hs.loadSpoon('LaunchMode')
hs.loadSpoon('OpenMode')
hs.loadSpoon('CodeMode')
hs.loadSpoon('SnippetMode')
hs.loadSpoon('MediaMode')
hs.loadSpoon('WindowManager')
TextManipulation = hs.loadSpoon('TextManipulation')
hs.loadSpoon('TabMode')
hs.loadSpoon('ViMode')
hs.loadSpoon('Misc')

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
