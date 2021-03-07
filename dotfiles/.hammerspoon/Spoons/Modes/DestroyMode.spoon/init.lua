local DestroyMode = {}
DestroyMode.__index = DestroyMode

DestroyMode.lookup = {
    e = 'toEndOfWord',
    q = 'subword',
    w = 'word',
    a = 'toEndOfLine',
    i = 'toBeginningOfLine',
    v = 'line',
    x = 'character',
    tab = 'mode-forward',
    caps_lock = 'mode',
    left_shift = 'mode-backward',
}

function DestroyMode.handle(key)
    if key == 'spacebar' then
        hs.eventtap.keyStroke({}, 'delete', 0)
    elseif DestroyMode.lookup[key] then
        hs.execute("open -g 'hammerspoon://destroy-" .. DestroyMode.lookup[key] .. "'")
    elseif TextManipulation.wrapperKeyLookup[key] then
        keystroke = TextManipulation.wrapperKeyLookup[key]

        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'd', 0)
        hs.eventtap.keyStroke({}, 'i', 0)
        hs.eventtap.keyStroke(keystroke.mods, keystroke.key, 0)
    end
end

hs.urlevent.bind('destroy-toEndOfWord', function()
    Pending.run({
        function()
            if TextManipulation.canManipulateWithVim() then
                hs.eventtap.keyStroke({}, 'escape', 0)
                hs.eventtap.keyStroke({}, 'd', 0)
                hs.eventtap.keyStroke({}, 'e', 0)
            else
                hs.eventtap.keyStroke({'shift', 'alt'}, 'right', 0)
                hs.eventtap.keyStroke({}, 'delete', 0)
            end
        end,
        function()
            if TextManipulation.canManipulateWithVim() then
                hs.eventtap.keyStroke({}, 'escape', 0)
                hs.eventtap.keyStroke({}, 'd', 0)
                hs.eventtap.keyStroke({'shift'}, 'e', 0)
            else
                hs.eventtap.keyStroke({'shift', 'alt'}, 'right', 0)
                hs.eventtap.keyStroke({}, 'delete', 0)
            end
        end,
    })
end)

hs.urlevent.bind('destroy-subword', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'd', 0)
        hs.eventtap.keyStroke({}, 'i', 0)
        hs.eventtap.keyStroke({}, 'q', 0)
    end
end)

hs.urlevent.bind('destroy-word', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'd', 0)
        hs.eventtap.keyStroke({}, 'i', 0)
        hs.eventtap.keyStroke({}, 'w', 0)
    elseif appIs(iterm) then
        hs.eventtap.keyStroke({'ctrl'}, 'w', 0)
    else
        hs.eventtap.keyStroke({'alt'}, 'delete', 0)
    end
end)

hs.urlevent.bind('destroy-toEndOfLine', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({'shift'}, 'd', 0)
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'right', 0)
        hs.eventtap.keyStroke({}, 'delete', 0)
    end
end)

hs.urlevent.bind('destroy-toBeginningOfLine', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'left', 0)
        hs.eventtap.keyStroke({}, 'd', 0)
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'left', 0)
        hs.eventtap.keyStroke({}, 'delete', 0)
    end
end)

hs.urlevent.bind('destroy-line', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'd', 0)
        hs.eventtap.keyStroke({}, 'd', 0)
    else
        hs.eventtap.keyStroke({'cmd'}, 'left', 0)
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'right', 0)
        hs.eventtap.keyStroke({}, 'delete', 0)
    end
end)

hs.urlevent.bind('destroy-character', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'x', 0)
    else
        hs.eventtap.keyStroke({}, 'delete', 0)
    end
end)

DestroyMode.direction = nil
DestroyMode.key = nil

Modal.addWithMenubar({
    key = 'DestroyMode',
    title = function()
        return 'Destroy: ' .. (DestroyMode.direction or '') .. ' ' .. (DestroyMode.key or '')
    end,
    shortcuts = {
        items = {
            {key = ',', action = 'backward'},
            {key = ';', action = 'forward'},
            {key = 'v', action = 'line'},
        },
        callback = function(item)
            DestroyMode.actions[item.action]()
        end,
    },
    exited = function()
        DestroyMode.direction = nil
        DestroyMode.key = nil
    end,
})

function DestroyMode.triggerDirectionIfSet()
    if not DestroyMode.direction then
        return
    end

    if DestroyMode.direction == 'F' then
        action = 'forward'
    else
        action = 'backward'
    end
    DestroyMode.actions[action]()
end

function DestroyMode.enterModal(direction, key)
    DestroyMode.direction = direction or nil
    DestroyMode.key = key or nil
    Modal.enter('DestroyMode')
end

DestroyMode.actions = {
    backward = function()
        if not TextManipulation.canManipulateWithVim() then
            return Modal.exit()
        end

        DestroyMode.enterModal('B', DestroyMode.key)

        if not DestroyMode.key then
            return
        end

        if inCodeEditor() then
            DestroyMode.keymap[DestroyMode.key]()
            hs.eventtap.keyStroke({}, 'k', 0)
        end
    end,

    forward = function()
        if not TextManipulation.canManipulateWithVim() then
            return Modal.exit()
        end

        DestroyMode.enterModal('F', DestroyMode.key)

        if not DestroyMode.key then
            return
        end

        if inCodeEditor() then
            DestroyMode.keymap[DestroyMode.key]()
        end
    end,

    line = function()
        DestroyMode.enterModal(DestroyMode.direction, "v")

        DestroyMode.triggerDirectionIfSet()
    end,
}

DestroyMode.keymap = {
    ['v'] = function()
        hs.eventtap.keyStroke({}, 'd', 0)
        hs.eventtap.keyStroke({}, 'd', 0)
    end,
}

hs.urlevent.bind('destroy-mode-forward', function()
    DestroyMode.enterModal('F')
end)

hs.urlevent.bind('destroy-mode', function()
    DestroyMode.enterModal()
end)

hs.urlevent.bind('destroy-mode-backward', function()
    DestroyMode.enterModal('B')
end)

return DestroyMode
