local LaunchMode = {}
LaunchMode.__index = LaunchMode

LaunchMode.lookup = {
    tab = 'windowHintsForCurrentApplication',
    q = {'quit', 'Kaleidoscope.app'},
    w = {'closeWindow', 'closeAllWindows', 'Transmit.app'},
    e = 'sublime',
    r = 'atom',
    t = 'iterm',
    caps_lock = 'windowHints',
    a = {'fantastical', 'alfredPreferences'},
    s = 'spotify',
    d = {'Discord.app', 'Ray.app'},
    f = 'Notion.app',
    g = 'chrome',
    left_shift = 'Dash.app',
    z = {'Slack.app', 'zoom.us.app', 'Screen.app'},
    x = {'de.beyondco.tinkerwell', 'de.beyondco.invoker', 'de.beyondco.helo'},
    c = 'Sublime Merge.app',
    v = 'TablePlus.app',
    b = 'finder',
    spacebar = {'open', 'bringAllWindowsToFront'},
}

function LaunchMode.before()
    if inCodeEditor() then
        spoon.HyperMode.forceEscape()
    end
end

hs.hints.titleMaxSize = 20
hs.hints.showTitleThresh = 20
hs.hints.fontSize = 20
hs.hints.iconAlpha = 1

function LaunchMode.windowHintsForCurrentApplication()
    hs.hints.style = nil
    hs.hints.windowHints(hs.window.focusedWindow():application():allWindows())
end

function LaunchMode.windowHints()
    hs.hints.style = 'vimperator'
    hs.hints.windowHints()
end

function LaunchMode.fantastical()
    fastKeyStroke({'alt', 'cmd'}, 'c')
end

function LaunchMode.alfredPreferences()
    hs.application.open('com.runningwithcrayons.Alfred-Preferences')
end

function LaunchMode.quit()
    spoon.CommandMode.quit()
end

function LaunchMode.closeWindow()
    spoon.CommandMode.closeWindow()
end

function LaunchMode.closeAllWindow()
    spoon.CommandMode.closeAllWindow()
end

function LaunchMode.open()
    spoon.HyperMode.open()
end

function LaunchMode.bringAllWindowsToFront()
    hs.application.frontmostApplication():activate(true)
end

function LaunchMode.fallback(value, key)
    if stringContains('.app', value) then
        hs.execute("open -a '" .. value .. "'")
    else
        LaunchMode.launchApp(value)
    end
end

function LaunchMode.launchApp(id)
    bundle = apps[id]

    if not bundle then
        return hs.application.open(id)
    end

    app = hs.application.frontmostApplication()
    isActive = app:bundleID() == bundle

    if id == 'iterm' then
        launchIterm()
    elseif id == 'spotify' then
        launchSpotify()
    elseif not isActive and not hasWindows(hs.application.get(bundle)) then
        if id ~= 'atom' then
            hs.application.open(bundle)
        end
    elseif not isActive then
        hs.application.get(bundle):activate()
    elseif multipleWindows(app) then
        spoon.SearchMode.windowsInCurrentApp()
    elseif not hasWindows(app) then
        hs.application.open(bundle)
    end
end

function launchIterm(callback)
    bundle = apps['iterm']
    app = hs.application.get(bundle)

    if app and app:isRunning() then
        triggerItermShortcut(callback)
    else
        hs.application.open(bundle)
        hs.timer.doAfter(1, function()
            triggerItermShortcut(callback)
        end)
    end
end

function triggerItermShortcut(callback)
    fastKeyStroke('`')

    if callback then
        callback()
    end
end

function launchSpotify()
    if appIs(spotify) then
        return spoon.WindowManager.next()
    end

    app = hs.application.get(spotify)

    if app and app:isRunning() then
        app:activate()
    else
        hs.execute('open -a "Spotify.app" https://open.spotify.com/playlist/2dMv6aYJXDoDA10nBPOvFN?si=EpPYjSQuSvKX92e4gJBf1Q')
    end
end

return LaunchMode
