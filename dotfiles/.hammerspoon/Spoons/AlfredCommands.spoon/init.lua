luna = require 'lunajson'

local AlfredCommands = {}
AlfredCommands.__index = AlfredCommands
AlfredCommands.all = {}

function AlfredCommands:add(key, name, handler)
    if self.all[key] then
        log.d('Command conflict for: ', k)
        hs.notify.new({title = 'Command conflict for: ' .. k}):send()

        return;
    end

    self.all[key] = {
        name = name,
        handler = handler,
    }

    return self
end

function AlfredCommands:setAlfredJson()
    local items = {}
    each(AlfredCommands.all, function(command, key)
        table.insert(items, {
            uid = key,
            title = command.name,
            arg = key,
            autocomplete = command.name,
        })
    end)

    io.open('/Users/nathan/.fuelingzsh/custom/alfred-commands.json', 'w')
        :write(luna.encode({items = items}))
        :close()
end

function AlfredCommands:trigger(key)
    command = self.all[key]

    if not command or not command.handler then
        return
    end

    command.handler()
end

function AlfredCommands:listen()
    hs.urlevent.bind('alfred-command', function(eventName, params)
        self:trigger(params.key)
    end)
end

return AlfredCommands
