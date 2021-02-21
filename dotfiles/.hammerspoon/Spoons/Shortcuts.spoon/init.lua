local Shortcuts = {}
Shortcuts.__index = Shortcuts
Shortcuts.all = {}
Shortcuts.appFunctionMapping = {
    notion = 'openNotionPage';
    discord = 'openDiscordChannel';
    iterm = 'typeAndEnter';
    atom = 'triggerInAtom';
    sublime = 'triggerInAtom';
    {app = 'atom', key = 'atomFile', func = 'goToFileInAtom'};
}

function Shortcuts:add(key, mapping)
    if self.all[key] then
        log.d('Merging shortcut for key: ', key)

        mapping = Shortcuts.mergeMapping(self.all[key], mapping)
    end

    self.all[key] = mapping

    return self
end

function Shortcuts.mergeMapping(dest, source)
    for k, v in pairs(source) do
        if dest[k] then
            log.d('Shortcut conflict for: ', k)
            hs.notify.new({title = 'Shortcut conflict for: ' .. k}):send()

            mapping = mergeMapping(self.all[key], mapping)
        end

        dest[k] = v
    end

    return dest
end

function Shortcuts:trigger(key)
    shortcut = self.all[key]

    if not shortcut then
        return
    end

    success = false

    for key, value in pairs(self.appFunctionMapping) do
        app = key
        func = value
        shortcutKey = key
        if type(value) == 'table' then
            app = value['app']
            func = value['func']
            shortcutKey = value['key']
        end

        if appIs(_G[app]) and shortcut[shortcutKey] then
            if type(shortcut[shortcutKey]) == 'function' then
                shortcut[shortcutKey]()
            else
                _G[func](shortcut[shortcutKey])
            end
            success = true
            break
        end
    end

    if not success then
        if shortcut['default'] then
            shortcut['default']()
        else
            return 'else'
        end
    end
end

function Shortcuts:listen()
    hs.urlevent.bind('shortcut-trigger', function(eventName, params)
        self:trigger(params.key)
    end)
end

return Shortcuts
