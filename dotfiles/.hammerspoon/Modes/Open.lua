local Open = {}
Open.__index = Open

loadCustomModal('Frequent')
loadCustomModal('Bookmarks')
loadModal('OpenIn')

Open.lookup = {
    tab = nil,
    q = nil,
    w = 'openInModal',
    e = 'sublime',
    r = 'atom',
    t = 'iterm',
    caps_lock = 'windowHints',
    a = 'openAppModal',
    s = 'slack',
    d = 'discord',
    f = 'openFrequentModal',
    g = 'chrome',
    left_shift = nil,
    z = 'fantastical',
    x = 'finder',
    c = 'sublimeMerge',
    v = 'tableplus',
    b = 'openBookmarksModal',
    spacebar = {'open', 'bringAllWindowsToFront'},
}

Modal.add({
    key = 'OpenApp',
    title = 'Open App',
    items = {
        -- q
        w = {name = 'Tinkerwell', app = 'de.beyondco.tinkerwell'},
        -- e
        r = {name = 'Ray', app = 'Ray.app'},
        t = {name = 'Transmit', app = 'Transmit.app'},
        -- yu
        i = {name = 'Invoker', app = 'de.beyondco.invoker'},
        -- o
        p = {name = 'System Preferences', app = 'System Preferences.app'},
        a = {name = 'Alfred Preferences', app = 'alfredPreferences'},
        s = {name = 'Spotify', app = 'spotify'},
        d = {name = 'Dash', app = 'Dash.app'},
        f = {name = 'Fantastical', app = 'fantastical'},
        -- g
        h = {name = 'Helo', app = 'de.beyondco.helo'},
        -- j
        k = {name = 'Kaleidoscope', app = 'Kaleidoscope.app'},
        -- l
        z = {name = 'Zoom', app = 'zoom.us.app'},
        -- xcvb
        n = {name = 'Notion', app = 'Notion.app'},
        m = {name = 'reMarkable', app = 'reMarkable.app'},
    },
    callback = function(item)
        Modal.exit()
        Open.fallback(item.app)
    end,
})

-- function Open.before()
--     if inCodeEditor() then
--         md.Hyper.forceEscape()
--     end
-- end

hs.hints.titleMaxSize = 20
hs.hints.showTitleThresh = 20
hs.hints.fontSize = 20
hs.hints.iconAlpha = 1

function Open.windowHintsForCurrentApplication()
    hs.hints.style = nil
    hs.hints.windowHints(hs.window.focusedWindow():application():allWindows())
end

function Open.windowHints()
    hs.hints.style = 'vimperator'
    hs.hints.windowHints()
end

function Open.fantastical()
    fastKeyStroke({'alt', 'cmd'}, 'c')
end

function Open.alfredPreferences()
    hs.application.open('com.runningwithcrayons.Alfred-Preferences')
end

function Open.quit()
    md.Command.quit()
end

function Open.closeWindow()
    md.Command.closeWindow()
end

function Open.closeAllWindow()
    md.Command.closeAllWindow()
end

function Open.open()
    md.Hyper.open()
end

function Open.bringAllWindowsToFront()
    hs.application.frontmostApplication():activate(true)
end

function Open.fallback(value, key)
    if Open[value] then
        Open[value]()
    elseif stringContains('.app', value) then
        hs.execute("open -a '" .. value .. "'")
    else
        Open.launchApp(value)
    end
end

function Open.launchApp(id)
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
    elseif not isActive then
        app = hs.application.get(bundle)
        if not hasWindows(app) then
            if id ~= 'atom' then
                hs.application.open(bundle)
            end
        else
            app:activate()

            if id == 'finder' and not multipleWindows(app) then
                hs.application.open(bundle)
            end
        end
    elseif multipleWindows(app) then
        Open.windowHintsForCurrentApplication()
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
        return md.WindowManager.next()
    end

    app = hs.application.get(spotify)

    if app and app:isRunning() then
        app:activate()
    else
        hs.execute('open -a "Spotify.app" https://open.spotify.com/playlist/2dMv6aYJXDoDA10nBPOvFN?si=EpPYjSQuSvKX92e4gJBf1Q')
    end
end

function Open.openAppModal()
    Modal.enter('OpenApp')
end

function Open.openFrequentModal()
    Modal.enter('OpenFrequent')
end

function Open.openBookmarksModal()
    Modal.enter('OpenBookmarks')
end

function Open.openInModal()
    Modal.enter('OpenIn')
end

return Open
