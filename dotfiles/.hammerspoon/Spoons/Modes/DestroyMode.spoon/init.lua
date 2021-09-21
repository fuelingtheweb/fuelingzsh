local DestroyMode = {}
DestroyMode.__index = DestroyMode

DestroyMode.lookup = {
    tab = 'modeForward',
    q = 'subword',
    w = 'word',
    e = 'toEndOfWord',
    r = 'untilMode',
    t = 'withWrapperKey',
    caps_lock = 'mode',
    a = 'toEndOfLine',
    s = 'withWrapperKey',
    d = 'withWrapperKey',
    f = 'withWrapperKey',
    g = 'toBeginningOfLine',
    left_shift = 'modeBackward',
    z = 'withWrapperKey',
    x = 'character',
    c = 'withWrapperKey',
    v = 'line',
    b = 'withWrapperKey',
    spacebar = 'simpleDelete',
}

function DestroyMode.withWrapperKey(key)
    keystroke = TextManipulation.wrapperKeyLookup[key]

    fastKeyStroke('escape')
    fastKeyStroke('d')
    fastKeyStroke('i')
    fastKeyStroke(keystroke.mods, keystroke.key)
end

function DestroyMode.simpleDelete()
    if inCodeEditor() then
        BracketMatching.cancel()
        BracketMatching.start()
    else
        fastKeyStroke('delete')
    end
end

function DestroyMode.toEndOfWord()
    Pending.run({
        function()
            if TextManipulation.canManipulateWithVim() then
                fastKeyStroke('escape')
                fastKeyStroke('d')
                fastKeyStroke('e')
            else
                fastKeyStroke({'shift', 'alt'}, 'right')
                fastKeyStroke('delete')
            end
        end,
        function()
            if TextManipulation.canManipulateWithVim() then
                fastKeyStroke('escape')
                fastKeyStroke('d')
                fastKeyStroke({'shift'}, 'e')
            else
                fastKeyStroke({'shift', 'alt'}, 'right')
                fastKeyStroke('delete')
            end
        end,
    })
end

function DestroyMode.subword()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('d')
        fastKeyStroke('i')
        fastKeyStroke('q')
    end
end

function DestroyMode.word()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('d')
        fastKeyStroke('i')
        fastKeyStroke('w')
    elseif appIs(iterm) then
        fastKeyStroke({'ctrl'}, 'w')
    else
        fastKeyStroke({'alt'}, 'delete')
    end
end

function DestroyMode.toEndOfLine()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke({'shift'}, 'd')
    else
        fastKeyStroke({'shift', 'cmd'}, 'right')
        fastKeyStroke('delete')
    end
end

function DestroyMode.toBeginningOfLine()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke({'shift', 'cmd'}, 'left')
        fastKeyStroke('d')
    else
        fastKeyStroke({'shift', 'cmd'}, 'left')
        fastKeyStroke('delete')
    end
end

function DestroyMode.line()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('d')
        fastKeyStroke('d')
    else
        fastKeyStroke({'cmd'}, 'left')
        fastKeyStroke({'shift', 'cmd'}, 'right')
        fastKeyStroke('delete')
    end
end

function DestroyMode.character()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('x')
    else
        fastKeyStroke('delete')
    end
end

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
            fastKeyStroke('k')
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
        fastKeyStroke('d')
        fastKeyStroke('d')
    end,
}

function DestroyMode.modeForward()
    DestroyMode.enterModal('F')
end

function DestroyMode.mode()
    DestroyMode.enterModal()
end

function DestroyMode.modeBackward()
    DestroyMode.enterModal('B')
end

function DestroyMode.untilMode()
    fastKeyStroke('escape')
    fastKeyStroke('d')
    fastKeyStroke('t')
end

return DestroyMode
