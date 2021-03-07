local KarabinerHandler = {}
KarabinerHandler.__index = KarabinerHandler

KarabinerHandler.modes = {
    'HyperMode',
    'TabMode',
    'PaneMode',
    'TestMode',
    'YankMode',
    'SelectUntilMode',
    'SelectInsideMode',
    'OpenMode',
    'PasteMode',
    'DestroyMode',
    'CaseMode',
    'SnippetMode',
    'GeneralMode',
    'GoogleMode',
    'ViMode',
    'CommandMode',
    'ExtendedCommandMode',
    'JumpToMode',
    'CaseDialog',
    'CodeMode',
    'ViVisualMode',
    'ChangeMode',
    'MediaMode',
    'LaunchMode',
    'AppMode',
    'SearchMode',
    'WindowManager',
}

each(KarabinerHandler.modes, function(mode)
    spoon[mode] = hs.loadSpoon('Modes/' .. mode)
end)

hs.urlevent.bind('handle-karabiner', function(eventName, params)
    local Mode = spoon[params.layer]

    if Mode[params.key] then
        return Mode[params.key]()
    elseif Mode.handle then
        Mode.handle(params.key)
    end
end)

return KarabinerHandler
