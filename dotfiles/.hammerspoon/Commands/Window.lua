local Window = {}
Window.__index = Window

Window.HalfsAndThirds = hs.loadSpoon('vendor/WindowHalfsAndThirds')

hs.grid.setGrid('12x4')
hs.grid.setMargins({x = 0, y = 0})
hs.window.animationDuration = 0

hs.grid.ui.textSize = 100
hs.grid.ui.showExtraKeys = false

function Window.missionControl()
    ks.fire({'fn', 'ctrl'}, 'up')
end

function Window.moveTotopRightSmall()
    hs.grid.set(hs.window.focusedWindow(), '9,0 3x1')
end

function Window.moveToMiddle()
    hs.grid.set(hs.window.focusedWindow(), '2,0 8x4')
end

function Window.moveToCenter()
    Window.HalfsAndThirds.center()
end

function Window.moveToNextDisplay()
    hs.grid.set(hs.window.focusedWindow(), '0,0 12x4')
    hs.window.focusedWindow():moveToScreen(hs.screen.mainScreen():next())
end

function Window.reset()
    Window.HalfsAndThirds.undo()
end

function Window.next()
    local windows = hs.fnutils.filter(
        hs.window.filter.default
        :getWindows(hs.window.filter.sortByFocusedLast),
        function(window) return window:title() end
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

function Window.nextInCurrentApp()
    md.Open.windowHintsForCurrentApplication()
    ks.key('b')

    local windows = hs.fnutils.filter(
        hs.window.filter
        .new({hs.application.frontmostApplication():name()})
        :getWindows(hs.window.filter.sortByFocusedLast),
        function(window) return window:title() end
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

function Window.settings()
    if fn.Alfred.visible() then
        hs.application.open('com.runningwithcrayons.Alfred-Preferences')
    else
        ks.cmd(',')
    end
end

function Window.moveMouseToOtherScreen()
    hs.mouse.setAbsolutePosition(
        hs.geometry.rectMidPoint(
            hs.mouse.getCurrentScreen():next():fullFrame()
        )
    )
end

function Window.toggleSidebar()
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

function Window.scrollScreenWithCursorAtEnd()
    if is.codeEditor() then
        md.Hyper.forceEscape()
        ks.sequence({'z', 'b'})
    end
end

function Window.scrollScreenWithCursorAtCenter()
    if is.codeEditor() then
        md.Hyper.forceEscape()
        ks.sequence({'z', 'z'})
    end
end

function Window.scrollScreenWithCursorAtTop()
    if is.codeEditor() then
        md.Hyper.forceEscape()
        ks.sequence({'z', 't'})
    end
end

function Window.toggleCodeFocus()
    ks.shiftAltCmd('z')
end

function Window.focusSidebarFileExplorer()
    fn.Code.run('Focus on Files Explorer')
end

function Window.focusSidebarSourceControl()
    fn.Code.run('Focus on Source Control View')
end

function Window.destroy()
    if is.In(finder, zoom, rayapp, slack, discord, 'org.hammerspoon.Hammerspoon', 'com.runningwithcrayons.Alfred-Preferences') then
        ks.close()
    elseif is.In(tableplus) then
        Window.quitApplication()
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

function Window.quitApplication()
    ks.cmd('q')
end

function Window.maximizeAfterDelay(delay)
    hs.timer.doAfter(delay or 0.5, Window.maximize)
end

function Window.maximize()
    Window.moveTo('maximize')
end

function Window.topLeft()
    Window.moveTo('topLeft')
end

function Window.topRight()
    Window.moveTo('topRight')
end

function Window.leftHalf()
    Window.moveTo('leftHalf')
end

function Window.bottomHalf()
    Window.moveTo('bottomHalf')
end

function Window.topHalf()
    Window.moveTo('topHalf')
end

function Window.rightHalf()
    Window.moveTo('rightHalf')
end

function Window.bottomLeft()
    Window.moveTo('bottomLeft')
end

function Window.bottomRight()
    Window.moveTo('bottomRight')
end

function Window.moveTo(position)
    Window.HalfsAndThirds[position]()
end

return Window
