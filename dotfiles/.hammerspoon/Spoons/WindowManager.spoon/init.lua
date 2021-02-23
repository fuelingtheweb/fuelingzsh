local WindowManager = {}
WindowManager.__index = WindowManager

function WindowManager.tab()
    WindowManager.moveToCenter()
end

function WindowManager.q()
end

function WindowManager.w()
end

function WindowManager.e()
end

function WindowManager.r()
end

function WindowManager.t()
end

function WindowManager.y()
end

function WindowManager.u()
    WindowManager.moveTo('topLeft')
end

function WindowManager.i()
    WindowManager.moveToMiddle()
end

function WindowManager.o()
    WindowManager.moveTo('topRight')
end

function WindowManager.p()
    WindowManager.appSettings()
end

function WindowManager.open_bracket()
end

function WindowManager.close_bracket()
    WindowManager.moveTotopRightSmall()
end

function WindowManager.caps_lock()
    -- Mission Control
    hs.eventtap.keyStroke({'fn', 'ctrl'}, 'up', 0)
end

function WindowManager.a()
end

function WindowManager.s()
end

function WindowManager.d()
    WindowManager.moveToNextDisplay()
end

function WindowManager.f()
    WindowManager.moveTo('maximize')
end

function WindowManager.g()
    WindowManager.showGrid()
end

function WindowManager.h()
    WindowManager.moveTo('leftHalf')
end

function WindowManager.j()
    WindowManager.moveTo('bottomHalf')
end

function WindowManager.k()
    WindowManager.moveTo('topHalf')
end

function WindowManager.l()
    WindowManager.moveTo('rightHalf')
end

function WindowManager.semicolon()
    WindowManager.next()
end

function WindowManager.quote()
    WindowManager.nextInCurrentApp()
end

function WindowManager.return_or_enter()
    WindowManager.reset()
end

function WindowManager.left_shift()
end

function WindowManager.z()
end

function WindowManager.x()
end

function WindowManager.c()
end

function WindowManager.v()
end

function WindowManager.b()
    WindowManager.toggleSidebar()
end

function WindowManager.n()
    WindowManager.moveTo('bottomLeft')
end

function WindowManager.m()
    WindowManager.moveMouseToOtherScreen()
end

function WindowManager.comma()
    WindowManager.moveTo('bottomRight')
end

function WindowManager.period()
end

function WindowManager.slash()
end

function WindowManager.right_shift()
end

function WindowManager.spacebar()
end

WindowManager.HalfsAndThirds = hs.loadSpoon('WindowHalfsAndThirds')

hs.grid.setGrid('12x4')
hs.grid.setMargins({x=0, y=0})
hs.window.animationDuration = 0

hs.grid.ui.textSize = 100
hs.grid.ui.showExtraKeys = false

function WindowManager.moveTo(position)
    WindowManager.HalfsAndThirds[position]()
end

function WindowManager.showGrid()
    hs.grid.toggleShow()
end

function WindowManager.moveTotopRightSmall()
    hs.grid.set(hs.window.focusedWindow(), '9,0 3x1')
end

function WindowManager.moveToMiddle()
    hs.grid.set(hs.window.focusedWindow(), '2,0 8x4')
end

function WindowManager.moveToCenter()
    WindowManager.HalfsAndThirds.center()
end

function WindowManager.moveToNextDisplay()
    hs.grid.set(hs.window.focusedWindow(), '0,0 12x4')
    hs.window.focusedWindow():moveToScreen(hs.screen.mainScreen():next())
end

function WindowManager.reset()
    WindowManager.HalfsAndThirds.undo()
end

function WindowManager.next()
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
end

function WindowManager.nextInCurrentApp()
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
end

function WindowManager.appSettings()
    if isAlfredVisible() then
        hs.application.open('com.runningwithcrayons.Alfred-Preferences')
    else
        hs.eventtap.keyStroke({'cmd'}, ',')
    end
end

function WindowManager.moveMouseToOtherScreen()
    hs.mouse.setAbsolutePosition(
        hs.geometry.rectMidPoint(hs.mouse.getCurrentScreen():next():fullFrame())
    )
end

function WindowManager.toggleSidebar()
    if appIs(finder) then
        hs.eventtap.keyStroke({'alt', 'cmd'}, 's')
    elseif appIs(sublimeMerge) then
        hs.eventtap.keyStroke({'cmd'}, 'K')
        hs.eventtap.keyStroke({'cmd'}, 'B')
    else
        hs.eventtap.keyStroke({'cmd'}, '\\')
    end
end

return WindowManager
