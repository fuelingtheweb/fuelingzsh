local AlfredCommands = {}
AlfredCommands.__index = AlfredCommands
AlfredCommands.all = {}

function AlfredCommands:add(key, name, icon, handler)
    if self.all[key] then
        log.d('Command conflict for: ', k)
        hs.notify.new({title = 'Command conflict for: ' .. k}):send()

        return;
    end

    self.all[key] = {
        name = name,
        icon = icon,
        handler = handler,
    }

    return self
end

function AlfredCommands:setAlfredJson()
    local items = {}
    each(AlfredCommands.all, function(command, key)
        iconPath = '~/Dropbox/Ftw/Alfred/Alfred.alfredpreferences/workflows/user.workflow.7CF5F8CA-70CF-4DDF-8543-642E861FCF88/'
        icon = 'icon.png'

        if command.icon then
            icon = command.icon
        end

        table.insert(items, {
            uid = key,
            title = command.name,
            arg = key,
            autocomplete = command.name,
            icon = {
                path = iconPath .. icon,
            },
        })
    end)

    hs.json.write({items = items}, '/Users/nathan/.fuelingzsh/custom/alfred-commands.json', false, true)
end

function AlfredCommands:trigger(key)
    command = self.all[key]

    if not command or not command.handler then
        return
    end

    command.handler()
end

function AlfredCommands:addFromConfig()
    dofile(hs.configdir .. '/config/custom/commands.lua')
end

function AlfredCommands:listen()
    hs.urlevent.bind('alfred-command', function(eventName, params)
        self:trigger(params.key)
    end)
end

return AlfredCommands
