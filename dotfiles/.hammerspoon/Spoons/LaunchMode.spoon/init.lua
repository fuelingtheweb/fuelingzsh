local LaunchMode = {}
LaunchMode.__index = LaunchMode

function LaunchMode.a()
    Pending.run({
        function()
            -- Fantastical
            hs.eventtap.keyStroke({'alt', 'cmd'}, 'c')
        end,
        function()
            hs.execute("open -g 'hammerspoon://launch-app?id=alfred-preferences'")
        end,
    })
end

function LaunchMode.d()
    Pending.run({
        function()
            hs.execute("open -a 'Discord.app'")
        end,
        function()
            hs.execute("open -a 'Ray.app'")
        end,
    })
end

function LaunchMode.z()
    Pending.run({
        function()
            hs.execute("open -a 'zoom.us.app'")
        end,
        function()
            hs.execute("open -a 'Screen.app'")
        end,
    })
end

function LaunchMode.x()
    Pending.run({
        function()
            hs.application.open('de.beyondco.tinkerwell')
        end,
        function()
            hs.application.open('de.beyondco.invoker')
        end,
        function()
            hs.application.open('de.beyondco.helo')
        end,
    })
end

function LaunchMode.spacebar()
    -- Bring all windows to front
    hs.application.frontmostApplication():activate(true)
end

LaunchMode.lookup = {
    q = {type = 'open', app = 'Kaleidoscope.app'},
    w = {type = 'open', app = 'Transmit.app'},
    e = {type = 'hs', app = 'sublime'},
    r = {type = 'hs', app = 'atom'},
    t = {type = 'hs', app = 'iterm'},
    caps_lock = {type = 'open', app = 'Dash.app'},
    s = {type = 'hs', app = 'spotify'},
    f = {type = 'open', app = 'Notion.app'},
    g = {type = 'hs', app = 'chrome'},
    c = {type = 'open', app = 'Sublime Merge.app'},
    v = {type = 'open', app = 'TablePlus.app'},
    b = {type = 'hs', app = 'finder'},
}

function LaunchMode.handle(key)
    if LaunchMode[key] then
        LaunchMode[key]()
    elseif LaunchMode.lookup[key] then
        local open = LaunchMode.lookup[key]

        if open.type == 'open' then
            hs.execute('open -a "' .. open.app .. '"')
        else
            hs.execute("open -g 'hammerspoon://launch-app?id=" .. open.app .. "'")
        end
    end
end

hs.urlevent.bind('launch-app', function(eventName, params)
    bundle = apps[params.id]
    app = hs.application.frontmostApplication()
    isActive = app:bundleID() == bundle

    if params.id == 'iterm' then
        launchIterm()
    elseif params.id == 'spotify' then
        launchSpotify()
    elseif params.id == 'alfred-preferences' then
        hs.application.open('com.runningwithcrayons.Alfred-Preferences')
    elseif not isActive and not hasWindows(hs.application.get(bundle)) then
        if params.id ~= 'atom' then
            hs.application.open(bundle)
        end
    elseif not isActive then
        hs.application.get(bundle):activate()
    elseif multipleWindows(app) then
        hs.eventtap.keyStroke({'shift', 'ctrl', 'alt', 'cmd'}, 'W')
    elseif not hasWindows(app) then
        hs.application.open(bundle)
    end
end)

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
    hs.eventtap.keyStroke({'shift', 'ctrl', 'alt', 'cmd'}, 'T')

    if callback then
        callback()
    end
end

function launchSpotify()
    app = hs.application.get(spotify)

    if app and app:isRunning() then
        app:activate()
    else
        hs.execute('open -a "Spotify.app" https://open.spotify.com/playlist/2dMv6aYJXDoDA10nBPOvFN?si=EpPYjSQuSvKX92e4gJBf1Q')
    end
end

return LaunchMode
