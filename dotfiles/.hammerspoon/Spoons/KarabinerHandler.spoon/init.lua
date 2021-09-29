local KarabinerHandler = {}
KarabinerHandler.__index = KarabinerHandler

spoon.SearchMode = hs.loadSpoon('Modes/SearchMode')

KarabinerHandler.modifier = nil

KarabinerHandler.lookup = {
    tab = 'TabMode',
    q = nil,
    w = nil,
    e = nil,
    r = 'PaneMode',
    t = {iterm = 'TerminalMode', atom = 'TestMode'},
    y = 'YankMode',
    u = 'AppMode',
    i = 'MakeMode',
    o = 'OpenMode',
    p = 'PasteMode',
    open_bracket = nil,
    close_bracket = nil,
    caps_lock = 'HyperMode',
    a = {iterm = 'ArtisanMode', default = 'CaseMode'},
    s = {
        iterm = 'TerminalSnippets',
        slack = 'SlackSnippets',
        atom = 'CodeSnippets',
        sublime = 'CodeSnippets'
    },
    d = 'ViMode',
    f = 'GeneralMode',
    g = 'GoogleMode',
    semicolon = 'CommandMode',
    quote = 'ExtendedCommandMode',
    return_or_enter = nil,
    z = 'CaseDialog',
    x = 'ExecuteMode',
    c = {iterm = 'GitMode', default = 'CodeMode'},
    v = 'ViVisualMode',
    b = nil,
    n = 'ChangeMode',
    m = 'DestroyMode',
    comma = 'SelectInsideMode',
    period = 'SelectUntilMode',
    slash = 'JumpToMode',
    spacebar = 'WindowManager',
}

local lookupKeys = {
    w = 'f17',
    o = 'f13',
    open_bracket = '[',
    close_bracket = ']',
    caps_lock = 'f16',
    semicolon = ';',
    quote = "'",
    return_or_enter = 'return',
    left_shift = 'f15',
    n = 'f14',
    comma = 'f18',
    period = 'f19',
    slash = 'f20',
    right_shift = 'f12',
    spacebar = 'space',
}

local availableKeys = {
    '1', '2', '3', '4', '5', '6', '7', '8', '9', '0',
    'tab', 'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', 'open_bracket', 'close_bracket',
    'caps_lock', 'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'semicolon', 'quote', 'return_or_enter',
    'left_shift', 'z', 'x', 'c', 'v', 'b', 'n', 'm', 'comma', 'period', 'slash', 'right_shift',
    'spacebar',
}

function KarabinerHandler.loadSpoons(modes)
    each(modes, function(mode, modifier)
        if not mode then
            return
        end

        if isTable(mode) then
            return KarabinerHandler.loadSpoons(mode)
        end

        if not spoon[mode] then
            spoon[mode] = hs.loadSpoon('Modes/' .. mode)

            KarabinerHandler.setupMode(spoon[mode])
        end
    end)
end

function KarabinerHandler.setupMode(mode)
    each(mode.lookup or {}, function(callable, key)
        if not isTable(callable) then
            return
        end

        mode.lookup[key] = hs.fnutils.map(callable, function(item)
            if mode[item] then
                return function()
                    mode[item](key)
                end
            elseif mode.fallback then
                return function()
                    mode.fallback(item, key)
                end
            end
        end)
    end)
end

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

function KarabinerHandler.callback(key)
    if not KarabinerHandler.modifier then
        return
    end

    mode = KarabinerHandler.lookup[KarabinerHandler.modifier]

    if isTable(mode) then
        each(mode, function(m, app)
            if (isTable(mode) and app == 'default') or appIs(apps[app]) then
                mode = m
            end
        end)
    end

    if isString(mode) then
        KarabinerHandler.handle(mode, key)
    end
end

function KarabinerHandler.setupKeys()
    each(KarabinerHandler.lookup, function(mode, modifier)
        if not mode then
            return
        end

        hs.hotkey.bind({'shift', 'ctrl', 'cmd'}, lookupKeys[modifier] or modifier, function()
            KarabinerHandler.modifier = modifier
        end)
    end)

    each(availableKeys, function(key)
        hs.hotkey.bind({'shift', 'ctrl', 'alt', 'cmd'}, lookupKeys[key] or key, '', function()
            KarabinerHandler.callback(key)
        end, function()
            KarabinerHandler.modifier = nil
        end, function()
            KarabinerHandler.callback(key)
        end)
    end)
end

hs.urlevent.bind('handle-karabiner', function(eventName, params)
    KarabinerHandler.handle(params.layer, params.key)
end)

KarabinerHandler.loadSpoons(KarabinerHandler.lookup)
KarabinerHandler.setupKeys()

function KarabinerHandler.compileJson()
    local items = {}

    each(KarabinerHandler.lookup, function(mode, key)
        if isTable(mode) then
            return
        end

        local item = {
            mode = mode,
            key = key,
            actions = {},
        }

        local Mode = spoon[mode]

        if Mode.lookup then
            each(Mode.lookup, function(action, key)
                if isTable(action) then
                    return;
                end

                table.insert(item.actions, {
                    name = action,
                    key = key,
                })
            end)
        end

        table.insert(items, item)
    end)

    hs.json.write({items = items}, '/Users/nathan/keymappings.json', false, true)
end

-- KarabinerHandler.compileJson()

return KarabinerHandler
