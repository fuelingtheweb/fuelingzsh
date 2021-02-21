local WindowManager = {}
WindowManager.__index = WindowManager
WindowManager.HalfsAndThirds = hs.loadSpoon('WindowHalfsAndThirds')

hs.grid.setGrid('12x4')
hs.grid.setMargins({x=0, y=0})
hs.window.animationDuration = 0

hs.grid.ui.textSize = 100
hs.grid.ui.showExtraKeys = false

hs.urlevent.bind('window-move', function(listener, params)
    WindowManager.HalfsAndThirds[params.to]()
end)

hs.urlevent.bind('window-showGrid', function(listener, params)
    hs.grid.toggleShow()
end)

hs.urlevent.bind('window-moveTotopRightSmall', function(listener, params)
    hs.grid.set(hs.window.focusedWindow(), '9,0 3x1')
end)

hs.urlevent.bind('window-moveToMiddle', function(listener, params)
    hs.grid.set(hs.window.focusedWindow(), '2,0 8x4')
end)

hs.urlevent.bind('window-moveToCenter', function(listener, params)
    WindowManager.HalfsAndThirds.center()
end)

hs.urlevent.bind('window-moveToNextDisplay', function(listener, params)
    hs.grid.set(hs.window.focusedWindow(), '0,0 12x4')
    hs.window.focusedWindow():moveToScreen(hs.screen.mainScreen():next())
end)

hs.urlevent.bind('window-reset', function(listener, params)
    WindowManager.HalfsAndThirds.undo()
end)

hs.urlevent.bind('window-next', function()
    local windows = hs.window.orderedWindows()
    if not windows[2] then
        return
    end

    local nextWin = windows[2]

    if nextWin:isMinimized() then
        nextWin:unminimize()
    else
        nextWin:focus()
    end
end)

hs.urlevent.bind('window-nextInCurrentApp', function()
    local app = hs.application.frontmostApplication()
    local windows = app:allWindows()

    if not windows[2] then
        return
    end

    local nextWin = windows[2]

    if nextWin:isMinimized() then
        nextWin:unminimize()
    else
        nextWin:focus()
    end
end)

function WindowManager.loadWindowsInAlfred(windows, minimum)
    if not windows or countTable(windows) < minimum then
        return
    end

    local items = {}
    each(windows, function(window)
        app = window:application()
        iconPath = '~/.fuelingzsh/custom/' .. app:name() .. '.png'
        hs.image.imageFromAppBundle(app:bundleID()):saveToFile(iconPath)
        table.insert(items, {
            uid = window:id(),
            title = window:title(),
            match = app:name() .. ' ' .. window:title(),
            arg = window:id(),
            icon = {
                path = iconPath,
            },
        })
    end)

    hs.json.write({items = items}, '/Users/nathan/.fuelingzsh/custom/windows.json', false, true)

    triggerAlfredWorkflow('windows', 'com.fuelingtheweb.commands')
end

hs.urlevent.bind('window-searchAll', function(eventName, params)
    windows = hs.window.filter.default
        :rejectApp('Sublime Text')
        :rejectApp('Atom')
        :rejectApp('Finder')
        :rejectApp('Google Chrome')
        :rejectApp('Sublime Merge')
        :rejectApp('Notion')
        :rejectApp('Spotify')
        :rejectApp('Invoker')
        :rejectApp('Dash')
        :getWindows(hs.window.filter.sortByFocusedLast)

    WindowManager.loadWindowsInAlfred(windows, 1)
end)

hs.urlevent.bind('window-searchInCurrentApp', function(eventName, params)
    windows = hs.window.filter.new({hs.application.frontmostApplication():name()}):getWindows(hs.window.filter.sortByFocusedLast)

    WindowManager.loadWindowsInAlfred(windows, 2)
end)

hs.urlevent.bind('window-focus', function(eventName, params)
    hs.window(tonumber(params.id)):focus()
end)

hs.urlevent.bind('window-bringAllToFront', function(eventName, params)
    hs.application.frontmostApplication():activate(true)
end)

return WindowManager
