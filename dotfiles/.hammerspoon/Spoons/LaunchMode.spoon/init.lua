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

return obj
