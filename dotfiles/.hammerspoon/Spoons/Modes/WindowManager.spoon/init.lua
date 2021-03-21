local WindowManager = {}
WindowManager.__index = WindowManager

WindowManager.lookup = {
    tab = 'moveToCenter',
    q = nil,
    w = nil,
    e = nil,
    r = nil,
    t = nil,
    caps_lock = 'missionControl',
    a = nil,
    s = nil,
    d = 'moveToNextDisplay',
    f = 'maximize',
    g = 'showGrid',
    left_shift = nil,
    z = nil,
    x = nil,
    c = nil,
    v = nil,
    b = 'toggleSidebar',

    y = nil,
    u = 'topLeft',
    i = 'moveToMiddle',
    o = 'topRight',
    p = 'appSettings',
    open_bracket = nil,
    close_bracket = 'moveTotopRightSmall',
    h = 'leftHalf',
    j = 'bottomHalf',
    k = 'topHalf',
    l = 'rightHalf',
    semicolon = 'next',
    quote = 'nextInCurrentApp',
    return_or_enter = 'reset',
    n = 'bottomLeft',
    m = 'moveMouseToOtherScreen',
    comma = 'bottomRight',
    period = nil,
    slash = nil,
    right_shift = nil,
}

function WindowManager.fallback(location)
    WindowManager.moveTo(location)
end

function WindowManager.missionControl()
    fastKeyStroke({'fn', 'ctrl'}, 'up')
end

WindowManager.HalfsAndThirds = hs.loadSpoon('vendor/WindowHalfsAndThirds')

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
        fastKeyStroke({'cmd'}, ',')
    end
end

function WindowManager.moveMouseToOtherScreen()
    hs.mouse.setAbsolutePosition(
        hs.geometry.rectMidPoint(hs.mouse.getCurrentScreen():next():fullFrame())
    )
end

function WindowManager.toggleSidebar()
    if appIs(finder) then
        fastKeyStroke({'alt', 'cmd'}, 's')
    elseif appIs(sublimeMerge) then
        fastKeyStroke({'cmd'}, 'k')
        fastKeyStroke({'cmd'}, 'b')
    else
        fastKeyStroke({'cmd'}, '\\')
    end
end

return WindowManager
