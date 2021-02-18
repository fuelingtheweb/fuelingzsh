local KarabinerHandler = {}
KarabinerHandler.__index = KarabinerHandler

local ModeLookup = {
    ['TestMode'] = hs.loadSpoon('TestMode'),
    ['ViMode'] = hs.loadSpoon('ViMode'),
}

hs.urlevent.bind('handle-karabiner', function(eventName, params)
    local Mode = ModeLookup[params.layer]

    if Mode.lookup[params.key] then
        Mode.lookup[params.key]()
    end
end)

return KarabinerHandler
