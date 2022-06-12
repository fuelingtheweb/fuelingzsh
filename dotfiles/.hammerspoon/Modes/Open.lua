local Open = {}
Open.__index = Open

Modal.loadCustom('Frequent')
Modal.loadCustom('Bookmarks.Index')
Modal.load('OpenIn')

Open.lookup = {
    tab = 'invoker',
    r = 'vscode',
    w = 'openInModal',
    e = 'tinkerwell',
    q = 'Ray.app',
    t = 'iterm',
    caps_lock = 'windowHints',
    a = 'openAppModal',
    s = 'slack',
    d = 'discord',
    f = 'openFrequentModal',
    g = 'chrome',
    left_shift = 'fantastical',
    z = 'zoom',
    x = 'finder',
    c = 'sublimeMerge',
    v = 'tableplus',
    b = 'openBookmarksModal',
    spacebar = cm.Search.allWindows,
}

Modal.add({
    key = 'OpenApp',
    title = 'Open App',
    items = {
        -- qwer
        t = {name = 'Transmit', app = 'Transmit.app'},
        -- yuio
        p = {name = 'System Preferences', app = 'System Preferences.app'},
        a = {name = 'Alfred Preferences', app = 'alfredPreferences'},
        s = {name = 'Spotify', app = 'spotify'},
        d = {name = 'Dash', app = 'Dash.app'},
        -- fg
        h = {name = 'Helo', app = 'de.beyondco.helo'},
        -- j
        k = {name = 'Kaleidoscope', app = 'Kaleidoscope.app'},
        -- lzxcvbn
        m = {name = 'reMarkable', app = 'reMarkable.app'}
    },
    callback = function(item)
        Modal.exit()
        Open.fallback(item.app)
    end,
})

-- hs.hints.titleMaxSize = 20
hs.hints.showTitleThresh = 20
hs.hints.fontSize = 20
hs.hints.iconAlpha = 1
hs.hints.style = nil

function Open.windowHintsForCurrentApplication()
    hs.hints.style = nil
    hs.hints.windowHints(hs.window.focusedWindow():application():allWindows())
end

function Open.windowHints()
    hs.hints.style = 'vimperator'
    hs.hints.windowHints()
end

function Open.fantastical()
    ks.altCmd('c')
end

function Open.alfredPreferences()
    hs.application.open('com.runningwithcrayons.Alfred-Preferences')
end

function Open.quit()
    md.Command.quit()
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
    elseif str.contains('.app', value) then
        hs.execute("open -a '" .. value .. "'")
    else
        Open.launchApp(value)
    end
end

function Open.launchApp(id)
    bundle = fn.app.bundles[id]

    if not bundle then
        return hs.application.open(id)
    end

    app = hs.application.frontmostApplication()
    isActive = app:bundleID() == bundle

    if id == 'iterm' then
        fn.iTerm.launch()
    elseif not isActive then
        app = hs.application.get(bundle)

        if not fn.app.hasWindows(app) then
            if id ~= 'vscode' then hs.application.open(bundle) end
        else
            app:activate()

            if id == 'finder' and not fn.app.multipleWindows(app) then
                hs.application.open(bundle)
            end
        end
    elseif fn.app.multipleWindows(app) or isActive then
        Open.windowHintsForCurrentApplication()
    elseif not fn.app.hasWindows(app) then
        hs.application.open(bundle)
    end
end

function triggerItermShortcut(callback)
    ks.key('`')

    if callback then
        callback()
    end
end

function Open.spotify()
    if is.In(spotify) then
        return cm.Window.next()
    end

    app = hs.application.get(spotify)

    if app and app:isRunning() then
        app:activate()
    else
        hs.execute('open -a "Spotify.app" https://open.spotify.com/playlist/40NEwyReWKPx4QaMNmZ6HS?si=ee74d9e6ccfd44dd')
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
