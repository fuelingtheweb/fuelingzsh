local KarabinerHandler = {}
KarabinerHandler.__index = KarabinerHandler

local ModeLookup = {
    ['HyperMode'] = hs.loadSpoon('HyperMode'),
    ['TabMode'] = hs.loadSpoon('TabMode'),
    ['PaneMode'] = hs.loadSpoon('PaneMode'),
    ['TestMode'] = hs.loadSpoon('TestMode'),
    ['SelectUntilMode'] = hs.loadSpoon('SelectUntilMode'),
    ['CaseMode'] = hs.loadSpoon('CaseMode'),
    ['GeneralMode'] = hs.loadSpoon('GeneralMode'),
    ['ViMode'] = hs.loadSpoon('ViMode'),
    ['CaseDialog'] = hs.loadSpoon('CaseDialog'),
    ['CodeMode'] = hs.loadSpoon('CodeMode'),
    ['AppMode'] = hs.loadSpoon('AppMode'),
    ['WindowManager'] = hs.loadSpoon('WindowManager'),
}

hs.urlevent.bind('handle-karabiner', function(eventName, params)
    local Mode = ModeLookup[params.layer]

    if Mode[params.key] then
        return Mode[params.key]()
    elseif Mode.handle then
        Mode.handle(params.key)
    end
end)

return KarabinerHandler
