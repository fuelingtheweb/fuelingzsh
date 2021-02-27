local DestroyMode = {}
DestroyMode.__index = DestroyMode

DestroyMode.lookup = {
    e = 'toEndOfWord',
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

DestroyModal = hs.loadSpoon('DestroyModal')

local keys = {
    {key = ',', action = 'backward'},
    {key = ';', action = 'forward'},
    {key = 'v', action = 'line'},
}

function DestroyMode.triggerDirectionIfSet()
    if not DestroyModal.direction then
        return
    end

    if DestroyModal.direction == 'F' then
        action = 'forward'
    else
        action = 'backward'
    end
    DestroyModal.actions[action]()
end

local actions = {
    backward = function()
        if not TextManipulation.canManipulateWithVim() then
            return spoon.ModalMgr:deactivate({DestroyModal.modalKey})
        end

        DestroyModal:enter('B', DestroyModal.key)

        if not DestroyModal.key then
            return
        end

        if inCodeEditor() then
            DestroyModal.keymap[DestroyModal.key]()
            hs.eventtap.keyStroke({}, 'k', 0)
        end
    end,

    forward = function()
        if not TextManipulation.canManipulateWithVim() then
            return spoon.ModalMgr:deactivate({DestroyModal.modalKey})
        end

        DestroyModal:enter('F', DestroyModal.key)

        if not DestroyModal.key then
            return
        end

        if inCodeEditor() then
            DestroyModal.keymap[DestroyModal.key]()
        end
    end,

    line = function()
        DestroyModal:enter(DestroyModal.direction, "v")

        DestroyMode.triggerDirectionIfSet()
    end,
}

local keyMap = {
    ['v'] = function()
        hs.eventtap.keyStroke({}, 'd', 0)
        hs.eventtap.keyStroke({}, 'd', 0)
    end,
}

DestroyModal:init(keys, actions, keyMap)
DestroyModal:start()

hs.urlevent.bind('destroy-mode-forward', function()
    DestroyModal:enter('F')
end)

hs.urlevent.bind('destroy-mode', function()
    DestroyModal:enter()
end)

hs.urlevent.bind('destroy-mode-backward', function()
    DestroyModal:enter('B')
end)

return DestroyMode
