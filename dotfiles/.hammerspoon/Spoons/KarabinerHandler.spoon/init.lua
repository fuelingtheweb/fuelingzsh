local KarabinerHandler = {}
KarabinerHandler.__index = KarabinerHandler

md = {}

KarabinerHandler.modifier = nil

KarabinerHandler.lookup = {
    tab = 'Tab',
    q = 'Numbers',
    w = nil,
    e = nil,
    r = 'Pane',
    t = {iterm = 'Terminal', atom = 'Test', vscode = 'Test'},
    y = {iterm = 'Yarn', default = 'Yank'},
    u = 'AppShortcut',
    i = 'Make',
    o = 'Open',
    p = 'Paste',
    open_bracket = 'Media',
    close_bracket = nil,
    caps_lock = 'Hyper',
    a = {iterm = 'Artisan', default = 'ChangeCase'},
    s = {
        iterm = 'TerminalSnippets',
        slack = 'SlackSnippets',
        atom = 'CodeSnippets',
        vscode = 'CodeSnippets',
        sublime = 'CodeSnippets',
    },
    d = 'Vi',
    f = 'General',
    g = {iterm = 'Git', default = 'Google'},
    semicolon = 'Command',
    quote = 'ExtendedCommand',
    return_or_enter = nil,
    z = 'CaseDialog',
    x = 'Execute',
    c = 'Code',
    v = 'ViVisual',
    b = nil,
    n = 'Change',
    m = 'Destroy',
    comma = 'SelectInside',
    period = 'SelectUntil',
    slash = 'JumpTo',
    spacebar = 'WindowManager',
}

local lookupKeys = {
    tab = 'q',
    q = 'w',
    w = 'f17',
    e = 'r',
    r = 't',
    t = 'y',
    y = 'u',
    u = 'i',
    i = 'o',
    o = 'f13',
    p = '[',
    open_bracket = ']',
    close_bracket = 'a',
    a = 's',
    s = 'd',
    d = 'f',
    f = 'g',
    g = 'h',
    h = 'j',
    j = 'k',
    k = 'l',
    l = ';',
    semicolon = "'",
    quote = 'return',
    return_or_enter = 'z',
    caps_lock = 'f16',
    left_shift = 'f15',
    z = 'x',
    x = 'c',
    c = 'v',
    v = 'b',
    b = 'n',
    n = 'f14',
    m = 'space',
    comma = 'f18',
    period = 'f19',
    slash = 'f20',
    right_shift = 'f12',
    spacebar = 'tab',
}

local availableKeys = {
    '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', 'tab', 'q', 'w', 'e', 'r',
    't', 'y', 'u', 'i', 'o', 'p', 'open_bracket', 'close_bracket', 'caps_lock',
    'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'semicolon', 'quote',
    'return_or_enter', 'left_shift', 'z', 'x', 'c', 'v', 'b', 'n', 'm', 'comma',
    'period', 'slash', 'right_shift', 'spacebar',
}

function KarabinerHandler.loadModes(modes)
    each(modes, function(mode, modifier)
        if not mode then
            return
        end

        if is.Table(mode) then
            return KarabinerHandler.loadModes(mode)
        end

        if not md[mode] then
            md[mode] = require('Modes.' .. mode)

            KarabinerHandler.setupMode(md[mode])
        end
    end)
end

function KarabinerHandler.setupMode(mode)
    each(mode.lookup or {}, function(callable, key)
        if not is.Table(callable) then
            return
        end

        mode.lookup[key] = hs.fnutils.map(callable, function(item)
            if mode[item] then
                return function() mode[item](key) end
            elseif mode.fallback then
                return function() mode.fallback(item, key) end
            end
        end)
    end)
end

function KarabinerHandler.handle(mode, key)
    if TextManipulation.vimEnabled then
        Modal.exit()
    end

    log.d('-----------------------In Handle Method-----------------------')
    log.d('Mode: ' .. mode)
    log.d('Key: ' .. key)

    local Mode = md[mode]

    if Mode.guard and not Mode.guard() then
        return
    end

    if Mode.before then
        Mode.before()
    end

    if Mode[key] then
        log.d('Calling Mode.key')
        return Mode[key]()
    elseif Mode.handle then
        log.d('Calling Mode.handle(key)')
        Mode.handle(key)
    elseif Mode.lookup and Mode.lookup[key] then
        local callable = Mode.lookup[key]

        if is.Table(callable) then
            log.d('Calling Pending.run')
            Pending.run(callable)
        elseif is.Function(callable) then
            log.d('Calling callable()')
            callable()
        elseif callable then
            if Mode[callable] then
                log.d('Calling Mode.callable(key)')
                Mode[callable](key)
            elseif Mode.fallback then
                log.d('Calling Mode.fallback(callable, key)')
                Mode.fallback(callable, key)
            end
        end
    end

    log.d('-----------------------End In Handle Method-----------------------')
end

function KarabinerHandler.callback(key)
    KarabinerHandler.currentKey = key

    if not KarabinerHandler.modifier then
        log.d('Action Key: ' .. key .. '. No modifier key.')
        return
    end

    local mode = KarabinerHandler.lookup[KarabinerHandler.modifier]

    log.d('-----------------------Handling Binding-----------------------')

    if is.Table(mode) then
        each(mode, function(m, app)
            if (is.Table(mode) and app == 'default') or is.In(fn.app.bundles[app]) then
                mode = m
            end
        end)
    end

    if is.String(mode) then
        log.d('String Mode: ' .. mode)
        KarabinerHandler.handle(mode, key)
    end

    log.d('-----------------------End Handling Binding-----------------------')
end

function KarabinerHandler.setupKeys()
    each(KarabinerHandler.lookup, function(mode, modifier)
        if not mode then
            return
        end

        hs.hotkey.bind(
            {'shift', 'ctrl', 'cmd'},
            lookupKeys[modifier] or modifier,
            function()
                KarabinerHandler.modifier = modifier
                log.d('!!!!!!!!!!!!!!!-----------------------Setting Modifier-----------------------')
                log.d('Modifier: ' .. modifier)
                log.d('KarabinerHandler.modifier: ' .. KarabinerHandler.modifier)
                log.d('-----------------------End Setting Modifier-----------------------')
            end
        )
    end)

    each(availableKeys, function(key)
        hs.hotkey.bind(
            {'shift', 'ctrl', 'alt', 'cmd'},
            lookupKeys[key] or key,
            '',
            function()
                log.d('-----------------------First Callback-----------------------')
                log.d('Key: ' .. key)
                log.d('With KarabinerHandler.modifier: ' .. KarabinerHandler.modifier)
                KarabinerHandler.callback(key)
                log.d('-----------------------End First Callback-----------------------')
            end,
            function()
                log.d('-----------------------Second Callback-----------------------')
                log.d('Key: ' .. key)
                log.d('With KarabinerHandler.modifier: ' .. KarabinerHandler.modifier or 'empty')
                -- hs.timer.doAfter(0.2, function()
                KarabinerHandler.modifier = nil
                KarabinerHandler.currentKey = nil
                log.d('Clearing KarabinerHandler.modifier: ' ..
                (KarabinerHandler.modifier or 'empty'))
                -- end)
                log.d('-----------------------End Second Callback-----------------------')
            end,
            function()
                log.d('-----------------------Third Callback-----------------------')
                log.d('Key: ' .. key)
                log.d('With KarabinerHandler.modifier: ' ..
                KarabinerHandler.modifier)
                KarabinerHandler.callback(key)
                log.d('-----------------------End Third Callback-----------------------')
            end)
    end)
end

hs.urlevent.bind('handle-karabiner', function(eventName, params)
    KarabinerHandler.handle(params.layer, params.key)
end)

KarabinerHandler.loadModes(KarabinerHandler.lookup)
KarabinerHandler.setupKeys()

function KarabinerHandler.compileJson()
    local items = {}

    each(KarabinerHandler.lookup, function(mode, key)
        if is.Table(mode) then
            return
        end

        local item = {mode = mode, key = key, actions = {}}

        local Mode = md[mode]

        if Mode.lookup then
            each(Mode.lookup, function(action, key)
                if is.Table(action) then
                    return
                end

                table.insert(item.actions, {name = action, key = key})
            end)
        end

        table.insert(items, item)
    end)

    hs.json.write({items = items}, '/Users/nathan/keymappings.json', false, true)
end

-- KarabinerHandler.compileJson()

return KarabinerHandler
