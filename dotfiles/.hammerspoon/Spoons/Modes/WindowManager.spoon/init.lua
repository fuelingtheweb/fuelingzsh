local WindowManager = {}
WindowManager.__index = WindowManager

WindowManager.lookup = {
    tab = 'moveToCenter',
    q = nil,
    w = nil,
    e = 'scrollScreenWithCursorAtEnd',
    r = 'scrollScreenWithCursorAtCenter',
    t = 'scrollScreenWithCursorAtTop',
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
    semicolon = nil,
    quote = nil,
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
    local windows = hs.fnutils.filter(hs.window.filter.default:getWindows(hs.window.filter.sortByFocusedLast), function(window)
        return window:title()
    end)
    local nextWin = windows[2]

    if not nextWin or nextWin:title() == currentTitle() then
        nextWin = windows[1]
    end

    if not nextWin then
        return
    end

    if nextWin:isMinimized() then
        nextWin:unminimize()
    else
        nextWin:focus()
    end
end

function WindowManager.nextInCurrentApp()
    if appIs(chrome) then
        spoon.OpenMode.windowHintsForCurrentApplication()
        fastKeyStroke('b')
        return
    end

    local windows = hs.fnutils.filter(hs.window.filter.new({hs.application.frontmostApplication():name()}):getWindows(hs.window.filter.sortByFocusedLast), function(window)
        return window:title()
    end)
    each(windows, function(window, index)
        log.d(index .. ': ' .. window:title())
    end)
    nextWin = windows[2]

    if not nextWin or nextWin:title() == currentTitle() then
        nextWin = windows[1]
    end

    if not nextWin then
        return
    end

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
    elseif appIs(slack) then
        fastKeyStroke({'cmd', 'shift'}, 'd')
    elseif appIs(tableplus) then
        fastKeyStroke({'cmd'}, '0')
    else
        fastKeyStroke({'cmd'}, '\\')
    end
end

function WindowManager.scrollScreenWithCursorAtEnd()
    if inCodeEditor() then
        spoon.HyperMode.forceEscape()
        fastKeyStroke('z')
        fastKeyStroke('b')
    end
end

function WindowManager.scrollScreenWithCursorAtCenter()
    if inCodeEditor() then
        spoon.HyperMode.forceEscape()
        fastKeyStroke('z')
        fastKeyStroke('z')
    end
end

function WindowManager.scrollScreenWithCursorAtTop()
    if inCodeEditor() then
        spoon.HyperMode.forceEscape()
        fastKeyStroke('z')
        fastKeyStroke('t')
    end
end

return WindowManager
