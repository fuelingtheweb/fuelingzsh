local obj = {}
obj.__index = obj

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

return obj
