local LaunchMode = {}
LaunchMode.__index = LaunchMode

LaunchMode.timer = nil

function LaunchMode.pending(firstCallback, secondCallback)
    if not LaunchMode.timer or not LaunchMode.timer:running() then
        LaunchMode.timer = hs.timer.doAfter(0.2, function()
            firstCallback()
        end)
    else
        if LaunchMode.timer and LaunchMode.timer:running() then
            LaunchMode.timer:stop()
        end

        secondCallback()
    end
end

function LaunchMode.a()
    -- Fanstastical or Alfred Preferences
    LaunchMode.pending(
        function()
            hs.eventtap.keyStroke({'alt', 'cmd'}, 'c')
        end,
        function()
            hs.execute("open -g 'hammerspoon://launch-app?id=alfred-preferences'")
        end
    )
end

function LaunchMode.z()
    -- Zoom or Screen
    LaunchMode.pending(
        function()
            hs.execute("open -a 'zoom.us.app'")
        end,
        function()
            hs.execute("open -a 'Screen.app'")
        end
    )
end

function LaunchMode.x()
    hs.execute("open -g 'hammerspoon://launch-beyond-code-app'")
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
    d = {type = 'open', app = 'Discord.app'},
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

hs.loadSpoon('ModalMgr')
modalKey = 'LaunchAppModal'

spoon.ModalMgr:new(modalKey)
modal = spoon.ModalMgr.modal_list[modalKey]

modal:bind('', 'escape', nil, function()
    spoon.ModalMgr:deactivate({modalKey})
end)

appToLaunch = nil

modal.entered = function()
    appToLaunch = 1
    restartTimer()
end

modal.exited = function()
    appToLaunch = nil
    timer:stop()
end

appMap = {
    [1] = 'de.beyondco.tinkerwell',
    [2] = 'de.beyondco.invoker',
    [3] = 'de.beyondco.helo',
}

function launchApp()
    hs.application.open(appMap[appToLaunch])
    spoon.ModalMgr:deactivateAll()
end

function restartTimer()
    timer:stop()
    timer:start()
end

timer = hs.timer.new(0.2, function()
    launchApp()
end)

hs.urlevent.bind('launch-beyond-code-app', function(eventName, params)
    if not appToLaunch then
        spoon.ModalMgr:deactivateAll()
        spoon.ModalMgr:activate({modalKey}, '#FFFFFF', false)
    else
        if appToLaunch < 3 then
            appToLaunch = appToLaunch + 1
        end

        if appToLaunch == 3 then
            launchApp()
        else
            restartTimer()
        end
    end
end)

return LaunchMode
