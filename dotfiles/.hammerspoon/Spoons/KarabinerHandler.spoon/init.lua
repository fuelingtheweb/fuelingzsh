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
    'TerminalSnippets',
    'SlackSnippets',
    'CodeSnippets',
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
    'AppMode',
    'SearchMode',
    'WindowManager',
    'MediaMode',
    'TerminalMode',
    'GitMode',
    'ArtisanMode',
}

each(KarabinerHandler.modes, function(modeName)
    Mode = hs.loadSpoon('Modes/' .. modeName)
    spoon[modeName] = Mode

    if not Mode.lookup or modeName == 'JumpToMode' then
        return
    end

    each(Mode.lookup, function(callable, key)
        if type(callable) == 'table' then
            Mode.lookup[key] = hs.fnutils.map(callable, function(item)
                local Mode = spoon[modeName]

                if Mode[item] then
                    return function()
                        spoon[modeName][item](key)
                    end
                elseif Mode.fallback then
                    return function()
                        spoon[modeName].fallback(item, key)
                    end
                end
            end)
        end
    end)
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
            Pending.run(callable)
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
    t = {iterm = 'TerminalMode', atom = 'TestMode'},
    y = 'YankMode',
    u = 'AppMode',
    i = 'MakeMode',
    o = 'OpenMode',
    p = 'PasteMode',
    -- ['['] = 'JumpToMode',
    -- [']'] = 'SelectUntilMode',
    a = {iterm = 'ArtisanMode', default = 'CaseMode'},
    s = {iterm = 'TerminalSnippets', slack = 'SlackSnippets', atom = 'CodeSnippets', sublime = 'CodeSnippets'},
    d = 'ViMode',
    f = 'GeneralMode',
    g = 'GoogleMode',
    [';'] = 'CommandMode',
    ["\'"] = 'ExtendedCommandMode',
    -- ['return'] = 'JumpToMode',
    z = 'CaseDialog',
    c = {iterm = 'GitMode', default = 'CodeMode'},
    v = 'ViVisualMode',
    n = 'ChangeMode',
    m = 'DestroyMode',
    [','] = 'SelectInsideMode',
    ['.'] = 'SelectUntilMode',
    ['/'] = 'JumpToMode',
    -- ['/'] = 'SearchMode',
    space = 'WindowManager',
}

KarabinerHandler.callback = function(item)
    if KarabinerHandler.modifier then
        mode = KarabinerHandler.modMapping[KarabinerHandler.modifier]

        if isTable(mode) then
            each(mode, function(m, app)
                if (isTable(mode) and app == 'default') or appIs(apps[app]) then
                    mode = m
                end
            end)
        end

        if isString(mode) then
            KarabinerHandler.handle(mode, item.ckey)
        end
    end
end

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
    {key = 'f13', ckey = 'o'},
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
    {key = 'f15', ckey = 'left_shift'},
    {key = 'z', ckey = 'z'},
    {key = 'x', ckey = 'x'},
    {key = 'c', ckey = 'c'},
    {key = 'v', ckey = 'v'},
    {key = 'b', ckey = 'b'},
    {key = 'f14', ckey = 'n'},
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
