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
    local key = params.key

    if Mode.guard and not Mode.guard() then
        return
    end

    if Mode[key] then
        return Mode[key]()
    elseif Mode.handle then
        Mode.handle(key)
    elseif Mode.lookup and Mode.lookup[key] then
        local callable = Mode.lookup[key]

        if type(callable) == 'table' then
            Pending.run(
                hs.fnutils.map(callable, function(item)
                    return function()
                        if Mode[item] then
                            Mode[item](key)
                        elseif Mode.fallback then
                            Mode.fallback(item, key)
                        end
                    end
                end)
            )
        elseif callable then
            if Mode[callable] then
                Mode[callable](key)
            elseif Mode.fallback then
                Mode.fallback(callable, key)
            end
        end
    end
end)

return KarabinerHandler
