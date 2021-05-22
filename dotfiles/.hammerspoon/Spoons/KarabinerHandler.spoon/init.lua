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
    'MakeMode',
    'LaunchMode',
    'AppMode',
    'SearchMode',
    'WindowManager',
    'MediaMode',
}

each(KarabinerHandler.modes, function(mode)
    spoon[mode] = hs.loadSpoon('Modes/' .. mode)
end)

function KarabinerHandler.handle(layer, key)
    local Mode = spoon[layer]

    if Mode.guard and not Mode.guard() then
        return
    end

    if Mode.before then
        Mode.before()
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
end

hs.urlevent.bind('handle-karabiner', function(eventName, params)
    KarabinerHandler.handle(params.layer, params.key)
end)

KarabinerHandler.modifier = nil
KarabinerHandler.modMapping = {
    f16 = 'HyperMode',
    tab = 'TabMode',
    r = 'PaneMode',
    t = 'TestMode',
    y = 'YankMode',
    u = 'SelectUntilMode',
    i = 'SelectInsideMode',
    o = 'OpenMode',
    p = 'PasteMode',
    ['['] = 'DestroyMode',
    a = 'CaseMode',
    s = 'SnippetMode',
    d = 'ViMode',
    f = 'GeneralMode',
    g = 'GoogleMode',
    [';'] = 'CommandMode',
    ["\'"] = 'ExtendedCommandMode',
    ['return'] = 'JumpToMode',
    z = 'CaseDialog',
    c = 'CodeMode',
    v = 'ViVisualMode',
    n = 'ChangeMode',
    m = 'MakeMode',
    [','] = 'LaunchMode',
    ['.'] = 'AppMode',
    ['/'] = 'SearchMode',
    space = 'WindowManager',
}

KarabinerHandler.callback = function(item)
    if KarabinerHandler.modifier then
        KarabinerHandler.handle(KarabinerHandler.modMapping[KarabinerHandler.modifier], item.ckey)
    end
end

hs.hotkey.alertDuration = 0
each(KarabinerHandler.modMapping, function(mode, key)
    hs.hotkey.bind({'shift', 'ctrl', 'cmd'}, key, function()
        KarabinerHandler.modifier = key
    end)
end)

allKeys = {
    {key = '1', ckey = '1'},
    {key = '2', ckey = '2'},
    {key = '3', ckey = '3'},
    {key = '4', ckey = '4'},
    {key = '5', ckey = '5'},
    {key = '6', ckey = '6'},
    {key = '7', ckey = '7'},
    {key = '8', ckey = '8'},
    {key = '9', ckey = '9'},
    {key = '0', ckey = '0'},
    {key = 'tab', ckey = 'tab'},
    {key = 'q', ckey = 'q'},
    {key = 'f17', ckey = 'w'},
    {key = 'e', ckey = 'e'},
    {key = 'r', ckey = 'r'},
    {key = 't', ckey = 't'},
    {key = 'y', ckey = 'y'},
    {key = 'u', ckey = 'u'},
    {key = 'i', ckey = 'i'},
    {key = 'o', ckey = 'o'},
    {key = 'p', ckey = 'p'},
    {key = '[', ckey = 'open_bracket'},
    {key = ']', ckey = 'close_bracket'},
    {key = 'f16', ckey = 'caps_lock'},
    {key = 'a', ckey = 'a'},
    {key = 's', ckey = 's'},
    {key = 'd', ckey = 'd'},
    {key = 'f', ckey = 'f'},
    {key = 'g', ckey = 'g'},
    {key = 'h', ckey = 'h'},
    {key = 'j', ckey = 'j'},
    {key = 'k', ckey = 'k'},
    {key = 'l', ckey = 'l'},
    {key = ';', ckey = 'semicolon'},
    {key = "'", ckey = 'quote'},
    {key = 'return', ckey = 'return_or_enter'},
    {key = 'shift', ckey = 'left_shift'},
    {key = 'z', ckey = 'z'},
    {key = 'x', ckey = 'x'},
    {key = 'c', ckey = 'c'},
    {key = 'v', ckey = 'v'},
    {key = 'b', ckey = 'b'},
    {key = 'n', ckey = 'n'},
    {key = 'm', ckey = 'm'},
    {key = 'f18', ckey = 'comma'},
    {key = 'f19', ckey = 'period'},
    {key = 'f20', ckey = 'slash'},
    {key = 'rightshift', ckey = 'right_shift'},
    {key = 'space', ckey = 'spacebar'},
}
each(allKeys, function(item)
    hs.hotkey.bind({'shift', 'ctrl', 'alt', 'cmd'}, item.key, '', function()
        KarabinerHandler.callback(item)
    end, function()
        KarabinerHandler.modifier = nil
    end, function()
        KarabinerHandler.callback(item)
    end)
end)

return KarabinerHandler
