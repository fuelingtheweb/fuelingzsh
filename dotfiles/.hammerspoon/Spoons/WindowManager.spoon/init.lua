local obj = {}
obj.__index = obj

WindowHalfsAndThirds = hs.loadSpoon('WindowHalfsAndThirds')

hs.grid.setGrid('12x4')
hs.grid.setMargins({x=0, y=0})
hs.window.animationDuration = 0

hs.grid.ui.textSize = 100
hs.grid.ui.showExtraKeys = false

hs.urlevent.bind('window-move', function(listener, params)
    WindowHalfsAndThirds[params.to]()
end)

hs.urlevent.bind('window-showGrid', function(listener, params)
    hs.grid.toggleShow()
end)

hs.urlevent.bind('window-moveToMiddle', function(listener, params)
    hs.grid.set(hs.window.focusedWindow(), '2,0 8x4')
end)

hs.urlevent.bind('window-moveToCenter', function(listener, params)
    WindowHalfsAndThirds.center()
end)

hs.urlevent.bind('window-moveToNextDisplay', function(listener, params)
    hs.grid.set(hs.window.focusedWindow(), windowPositions.full)
    hs.window.focusedWindow():moveToScreen(hs.screen.mainScreen():next())
end)

hs.urlevent.bind('window-reset', function(listener, params)
    WindowHalfsAndThirds.undo()
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

return obj
