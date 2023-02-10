local Shortcuts = {}
Shortcuts.__index = Shortcuts
Shortcuts.all = {}
Shortcuts.appFunctionMapping = {
    discord = fn.Discord.openChannel,
    slack = fn.Slack.openChannel,
    iterm = ks.typeAndEnter,
    warp = ks.typeAndEnter,
    vscode = fn.Code.run,
    chrome = '',
}

function Shortcuts:add(key, mapping)
    if self.all[key] then
        mapping = Shortcuts.mergeMapping(self.all[key], mapping)
    end

    self.all[key] = mapping

    return self
end

function Shortcuts.mergeMapping(dest, source)
    for k, v in pairs(source) do
        if dest[k] then
            hs.alert.show('Shortcut conflict for: ', k)
            hs.notify.new({title = 'Shortcut conflict for: ' .. k}):send()

            mapping = mergeMapping(self.all[key], mapping)
        end

        dest[k] = v
    end

    return dest
end

function Shortcuts:handle(key)
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

        if is.In(_G[app]) and shortcut[shortcutKey] then
            if type(shortcut[shortcutKey]) == 'function' then
                shortcut[shortcutKey]()
            elseif is.Function(func) then
                func(shortcut[shortcutKey])
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

function Shortcuts:addFromConfig()
    require('config.shortcuts')
    require('config.custom.shortcuts')
end

return Shortcuts
