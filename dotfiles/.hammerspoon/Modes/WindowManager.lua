local WindowManager = {}
WindowManager.__index = WindowManager

WindowManager.lookup = {
    tab = 'moveToCenter',
    q = 'quitApplication',
    w = 'toggleCodeFocus',
    e = 'scrollScreenWithCursorAtEnd',
    r = 'scrollScreenWithCursorAtCenter',
    t = 'scrollScreenWithCursorAtTop',
    caps_lock = 'missionControl',
    a = 'toggleAudio',
    s = 'toggleScreenShare',
    d = 'moveToNextDisplay',
    f = 'maximize',
    g = hs.grid.toggleShow,
    left_shift = nil,
    z = 'toggleAudioAndVideo',
    x = 'focusSidebarFileExplorer',
    c = 'focusSidebarSourceControl',
    v = 'toggleVideo',
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
    semicolon = 'moveMouseToOtherScreen',
    quote = nil,
    return_or_enter = 'reset',
    n = 'bottomLeft',
    m = 'destroy',
    comma = 'bottomRight',
    period = nil,
    slash = nil,
    right_shift = nil,
}

function WindowManager.fallback(location)
    WindowManager.moveTo(location)
end

function WindowManager.missionControl()
    ks.fire({'fn', 'ctrl'}, 'up')
end

WindowManager.HalfsAndThirds = hs.loadSpoon('vendor/WindowHalfsAndThirds')

hs.grid.setGrid('12x4')
hs.grid.setMargins({x = 0, y = 0})
hs.window.animationDuration = 0

hs.grid.ui.textSize = 100
hs.grid.ui.showExtraKeys = false

function WindowManager.moveTo(position)
    WindowManager.HalfsAndThirds[position]()
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
    local windows = hs.fnutils.filter(
        hs.window.filter.default:getWindows(hs.window.filter.sortByFocusedLast),
        function(window)
            return window:title()
        end
    )
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
    md.Open.windowHintsForCurrentApplication()
    ks.key('b')
    -- if is.chrome() then
    --     return
    -- end

    local windows = hs.fnutils.filter(hs.window.filter.new({
        hs.application.frontmostApplication():name()
    }):getWindows(hs.window.filter.sortByFocusedLast), function(window)
        return window:title()
    end)
    each(windows, function(window, index) log.d(index .. ': ' .. window:title()) end)
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
    if fn.Alfred.visible() then
        hs.application.open('com.runningwithcrayons.Alfred-Preferences')
    else
        ks.cmd(',')
    end
end

function WindowManager.moveMouseToOtherScreen()
    hs.mouse.setAbsolutePosition(
        hs.geometry.rectMidPoint(
            hs.mouse.getCurrentScreen():next():fullFrame()
        )
    )
end

function WindowManager.toggleSidebar()
    if is.finder() then
        ks.altCmd('s')
    elseif is.In(sublimeMerge) then
        ks.cmd('k').cmd('b')
    elseif is.In(slack) then
        ks.shiftCmd('d')
    elseif is.In(tableplus) then
        ks.cmd('0')
    else
        ks.cmd('\\')
    end
end

function WindowManager.scrollScreenWithCursorAtEnd()
    if is.codeEditor() then
        md.Hyper.forceEscape()
        ks.sequence({'z', 'b'})
    end
end

function WindowManager.scrollScreenWithCursorAtCenter()
    if is.codeEditor() then
        md.Hyper.forceEscape()
        ks.sequence({'z', 'z'})
    end
end

function WindowManager.scrollScreenWithCursorAtTop()
    if is.codeEditor() then
        md.Hyper.forceEscape()
        ks.sequence({'z', 't'})
    end
end

function WindowManager.toggleAudio()
    ks.shiftCmd('a')
end

function WindowManager.toggleScreenShare()
    ks.shiftCmd('s')
end

function WindowManager.toggleVideo()
    ks.shiftCmd('v')
end

function WindowManager.toggleAudioAndVideo()
    WindowManager.toggleAudio()
    WindowManager.toggleVideo()
end

function WindowManager.toggleCodeFocus()
    ks.shiftAltCmd('z')
end

function WindowManager.focusSidebarFileExplorer()
    fn.Code.run('Focus on Files Explorer')
end

function WindowManager.focusSidebarSourceControl()
    fn.Code.run('Focus on Source Control View')
end

function WindowManager.destroy()
    if is.In(finder, zoom, rayapp, slack, discord) then
        ks.close()
    else
        ks.shiftCmd('w')
    end

    if is.chrome() then
        hs.timer.doAfter(1, function()
            app = hs.application.frontmostApplication()

            if next(app:visibleWindows()) == nil then
                app:hide()
            end
        end)
    end
end

function WindowManager.quitApplication()
    ks.cmd('q')
end

return WindowManager
