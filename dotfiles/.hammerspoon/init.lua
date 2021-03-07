hs.loadSpoon('Variables')
hs.loadSpoon('Functions')
Ray = hs.loadSpoon('Ray')
Pending = hs.loadSpoon('Pending')
Modal = hs.loadSpoon('Modal')
hs.loadSpoon('Watchers')
TextManipulation = hs.loadSpoon('TextManipulation')
Artisan = hs.loadSpoon('Artisan')
HyperMode = hs.loadSpoon('HyperMode')
WindowManager = hs.loadSpoon('WindowManager')
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
