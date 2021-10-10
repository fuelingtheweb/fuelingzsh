local OpenMode = {}
OpenMode.__index = OpenMode

dofile(hs.configdir .. '/config/custom/open-frequent-modal.lua')
dofile(hs.configdir .. '/config/custom/open-bookmarks-modal.lua')
dofile(hs.configdir .. '/Spoons/Modes/OpenMode.spoon/open-in-modal.lua')

OpenMode.lookup = {
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
        OpenMode.fallback(item.app)
    end,
})

-- function OpenMode.before()
--     if inCodeEditor() then
--         spoon.HyperMode.forceEscape()
--     end
-- end

hs.hints.titleMaxSize = 20
hs.hints.showTitleThresh = 20
hs.hints.fontSize = 20
hs.hints.iconAlpha = 1

function OpenMode.windowHintsForCurrentApplication()
    hs.hints.style = nil
    hs.hints.windowHints(hs.window.focusedWindow():application():allWindows())
end

function OpenMode.windowHints()
    hs.hints.style = 'vimperator'
    hs.hints.windowHints()
end

function OpenMode.fantastical()
    fastKeyStroke({'alt', 'cmd'}, 'c')
end

function OpenMode.alfredPreferences()
    hs.application.open('com.runningwithcrayons.Alfred-Preferences')
end

function OpenMode.quit()
    spoon.CommandMode.quit()
end

function OpenMode.closeWindow()
    spoon.CommandMode.closeWindow()
end

function OpenMode.closeAllWindow()
    spoon.CommandMode.closeAllWindow()
end

function OpenMode.open()
    spoon.HyperMode.open()
end

function OpenMode.bringAllWindowsToFront()
    hs.application.frontmostApplication():activate(true)
end

function OpenMode.fallback(value, key)
    if OpenMode[value] then
        OpenMode[value]()
    elseif stringContains('.app', value) then
        hs.execute("open -a '" .. value .. "'")
    else
        OpenMode.launchApp(value)
    end
end

function OpenMode.launchApp(id)
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
        OpenMode.windowHintsForCurrentApplication()
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

function OpenMode.openAppModal()
    Modal.enter('OpenApp')
end

function OpenMode.openFrequentModal()
    Modal.enter('OpenFrequent')
end

function OpenMode.openBookmarksModal()
    Modal.enter('OpenBookmarks')
end

function OpenMode.openInModal()
    Modal.enter('OpenIn')
end

return OpenMode
