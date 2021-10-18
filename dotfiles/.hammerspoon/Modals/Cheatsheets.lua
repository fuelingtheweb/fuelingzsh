local Cheatsheets = {}
Cheatsheets.__index = Cheatsheets

function Cheatsheets.setupModal()
    Modal.add({
        key = 'Cheatsheets',
        title = 'Cheatsheets',
        defaults = false,
        showCheatsheetOnEnter = true,
        items = Cheatsheets.items(),
        callback = function(item)
            Modal.exit()
            spoon.KarabinerHandler.handle(item.mode, item.actionKey)
        end,
    })
end

Cheatsheets.lookupKeys = {
    caps_lock = 'escape',
    open_bracket = '[',
    close_bracket = ']',
    semicolon = ';',
    quote = "'",
    return_or_enter = 'return',
    comma = ',',
    period = '.',
    slash = '/',
    spacebar = 'space',
    left_shift = '1',
    right_shift = '0',
}

Cheatsheets.lookupApps = {
    atom = 'r',
    sublime = 'e',
    iterm = 't',
    slack = 's',
    default = 'return',
}

function Cheatsheets.items()
    local items = {}

    each(spoon.KarabinerHandler.lookup, function(mode, modifier)
        local name = mode

        if isTable(mode) then
            name = ''

            each(mode, function(mode, app)
                name = name .. app .. ': ' .. mode .. ', '
            end)

            local nestedItems = {}

            each(mode, function(mode, app)
                nestedItems[Cheatsheets.lookupApps[app]] = {name = app, title = app, key = app, defaults = false, items = Cheatsheets.nestedItems(mode)}
            end)

            items[Cheatsheets.lookupKeys[modifier] or modifier] = {name = name, title = name, key = modifier, defaults = false, items = nestedItems}

            return
        end

        items[Cheatsheets.lookupKeys[modifier] or modifier] = {name = name, title = mode, key = mode, defaults = false, items = Cheatsheets.nestedItems(mode)}
    end)

    return items
end

function Cheatsheets.nestedItems(mode)
    local items = {}

    each(md[mode].lookup or {}, function(method, key)
        name = (
            (key == 'left_shift' and '(left_shift) ' or nil)
            or (key == 'right_shift' and '(right_shift) ' or '')
        ) .. (isString(method) and method or '')
        items[Cheatsheets.lookupKeys[key] or key] = {name = name, mode = mode, actionKey = key}
    end)

    return items
end

Cheatsheets.setupModal()

return Cheatsheets
