local obj = {}
obj.__index = obj

hs.urlevent.bind('launch-app', function(eventName, params)
    bundle = apps[params.id]
    app = hs.application.frontmostApplication()
    isActive = app:bundleID() == bundle

    if params.id == 'iterm' then
        launchIterm()
    elseif not isActive and not hasWindows(hs.application.get(bundle)) then
        hs.application.open(bundle)
    elseif not isActive then
        hs.application.get(bundle):activate()
    elseif multipleWindows(app) then
        hs.eventtap.keyStroke({'shift', 'ctrl', 'alt', 'cmd'}, 'W')
    elseif not hasWindows(app) then
        hs.application.open(bundle)
    end
end)

function launchIterm(bundle)
    bundle = apps['iterm']
    app = hs.application.get(bundle)

    if app and app:isRunning() then
        triggerItermShortcut()
    else
        hs.application.open(bundle)
        hs.timer.doAfter(1, function()
            triggerItermShortcut()
        end)
    end
end

function triggerItermShortcut()
    hs.eventtap.keyStroke({'shift', 'ctrl', 'alt', 'cmd'}, 'T')
end

return obj
