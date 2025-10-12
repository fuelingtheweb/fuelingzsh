local Watchers = {}
Watchers.__index = Watchers

local wf = hs.window.filter
local allwindows = wf.new(nil)
hs.window.animationDuration = 0

-- allwindows:subscribe(wf.windowDestroyed, function(window, appName, reason)
--     local app = window:application()
--     local bundle = app:bundleID()
--     local count = 0

--     for k, v in pairs(app:visibleWindows()) do
--         if fn.table.has({preview, finder}, bundle) and v:title() == '' then
--         else
--             count = count + 1
--         end
--     end

--     if count < 1 then
--         if fn.table.has({preview, sublimeMerge, slack, spotify, zoom, rayapp, transmit}, bundle) then
--             app:kill()
--         elseif app:isFrontmost() then
--             app:hide()
--         end
--     end

--     cm.Window.focusFirst(
--         cm.Window.filtered(cm.Window.currentScreen())
--     )
-- end)

function Watchers.handleHammerspoonChanges(paths)
    local shouldRun = false

    fn.each(paths, function(path)
        if str.contains('.lua', path) then
            shouldRun = true
        end
    end)

    if shouldRun then
        hs.reload()
    end
end

pathWatchers = {
    hs.pathwatcher.new(
        os.getenv('HOME') .. '/.hammerspoon/',
        Watchers.handleHammerspoonChanges
    ),
    hs.pathwatcher.new(
        os.getenv('HOME') .. '/.hammerspoon/config/custom/',
        Watchers.handleHammerspoonChanges
    )
}

function Watchers.start()
    fn.each(pathWatchers, function(watcher)
        watcher:start()
    end)
end

hs.console.darkMode(true)

-- hs.logger:d('testing')
hs.logger.new('ftw-log', 'debug').e("Config loaded")

Watchers.start()

return Watchers
