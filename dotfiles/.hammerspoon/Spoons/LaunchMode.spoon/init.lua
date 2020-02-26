local obj = {}
obj.__index = obj

hs.urlevent.bind('launch-app', function(eventName, params)
    bundle = apps[params.id]
    app = hs.application.frontmostApplication()
    isActive = app:bundleID() == bundle

    if not isActive and not hasWindows(hs.application.get(bundle)) then
        hs.application.open(bundle)
    elseif not isActive then
        hs.application.get(bundle):activate()
    elseif multipleWindows(app) then
        hs.eventtap.keyStroke({'ctrl'}, 'tab')
    elseif not hasWindows(app) then
        hs.application.open(bundle)
    end
end)

return obj
