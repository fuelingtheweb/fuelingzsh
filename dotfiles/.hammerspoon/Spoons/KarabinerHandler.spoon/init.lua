local KarabinerHandler = {}
KarabinerHandler.__index = KarabinerHandler

local ModeLookup = {
    ['HyperMode'] = hs.loadSpoon('HyperMode'),
    ['TabMode'] = hs.loadSpoon('TabMode'),
    ['PaneMode'] = hs.loadSpoon('PaneMode'),
    ['TestMode'] = hs.loadSpoon('TestMode'),
    ['YankMode'] = hs.loadSpoon('YankMode'),
    ['SelectUntilMode'] = hs.loadSpoon('SelectUntilMode'),
    ['SelectInsideMode'] = hs.loadSpoon('SelectInsideMode'),
    ['OpenMode'] = hs.loadSpoon('OpenMode'),
    ['PasteMode'] = hs.loadSpoon('PasteMode'),
    ['DestroyMode'] = hs.loadSpoon('DestroyMode'),
    ['CaseMode'] = hs.loadSpoon('CaseMode'),
    ['SnippetMode'] = hs.loadSpoon('SnippetMode'),
    ['GeneralMode'] = hs.loadSpoon('GeneralMode'),
    ['GoogleMode'] = hs.loadSpoon('GoogleMode'),
    ['ViMode'] = hs.loadSpoon('ViMode'),
    ['CommandMode'] = hs.loadSpoon('CommandMode'),
    ['ExtendedCommandMode'] = hs.loadSpoon('ExtendedCommandMode'),
    ['JumpToMode'] = hs.loadSpoon('JumpToMode'),
    ['CaseDialog'] = hs.loadSpoon('CaseDialog'),
    ['CodeMode'] = hs.loadSpoon('CodeMode'),
    ['ChangeMode'] = hs.loadSpoon('ChangeMode'),
    ['MediaMode'] = hs.loadSpoon('MediaMode'),
    ['LaunchMode'] = hs.loadSpoon('LaunchMode'),
    ['AppMode'] = hs.loadSpoon('AppMode'),
    ['SearchMode'] = hs.loadSpoon('SearchMode'),
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
