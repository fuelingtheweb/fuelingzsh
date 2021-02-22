local KarabinerHandler = {}
KarabinerHandler.__index = KarabinerHandler

local ModeLookup = {
    ['TestMode'] = hs.loadSpoon('TestMode'),
    ['ViMode'] = hs.loadSpoon('ViMode'),
    ['CodeMode'] = hs.loadSpoon('CodeMode'),
}

hs.urlevent.bind('handle-karabiner', function(eventName, params)
    local Mode = ModeLookup[params.layer]

    if Mode[params.key] then
        return Mode[params.key]()
    end
end)

return KarabinerHandler
