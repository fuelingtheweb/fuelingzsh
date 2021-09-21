local JumpToMode = {}
JumpToMode.__index = JumpToMode

JumpToMode.lookup = {
    tab = nil,
    q = nil,
    w = nil,
    e = nil,
    r = nil,
    t = 'previousBlock',
    caps_lock = 'modeBackward',
    a = nil,
    s = 'singleQuote',
    d = 'doubleQuote',
    f = 'parenthesis',
    g = nil,
    left_shift = nil,
    z = 'backTick',
    x = nil,
    c = 'braces',
    v = nil,
    b = 'brackets',
    spacebar = nil,
}

JumpToMode.direction = nil
JumpToMode.key = nil

Modal.addWithMenubar({
    key = 'JumpToMode',
    title = function()
        return 'Jump to: ' .. (JumpToMode.direction or '') .. ' ' .. (JumpToMode.key or '')
    end,
    shortcuts = {
        items = {
            {key = "s", action = 'singleQuote'},
            {key = "d", action = 'doubleQuote'},
            {key = "z", action = 'backTick'},
            {key = "f", action = 'parenthesis'},
            {key = "c", action = 'braces'},
            {key = "b", action = 'brackets'},
            {key = ',', action = 'backward'},
            {key = ';', action = 'forward'},
        },
        callback = function(item)
            JumpToMode.actions[item.action]()
        end,
    },
    exited = function()
        JumpToMode.direction = nil
        JumpToMode.key = nil
    end,
})

function JumpToMode.triggerDirectionIfSet()
    if not JumpToMode.direction then
        return
    end

    if JumpToMode.direction == 'F' then
        action = 'forward'
    else
        action = 'backward'
    end
    JumpToMode.actions[action]()

    Modal.exit()
end

function JumpToMode.enterModal(direction, key)
    JumpToMode.direction = direction or nil
    JumpToMode.key = key or nil
    Modal.enter('JumpToMode')
end

function JumpToMode.beginJumpingForward()
    if not TextManipulation.canManipulateWithVim() then
        return
    end

    if inCodeEditor() then
        fastKeyStroke('l')
        fastKeyStroke('t')
    end
end

function JumpToMode.beginJumpingBackward()
    if not TextManipulation.canManipulateWithVim() then
        return
    end

    if inCodeEditor() then
        fastKeyStroke('h')
        fastKeyStroke({'shift'}, 't')
    end
end

JumpToMode.actions = {
    singleQuote = function()
        Pending.run({
            function()
                JumpToMode.enterModal(JumpToMode.direction, "'")

                JumpToMode.triggerDirectionIfSet()
            end,
            function()
                JumpToMode.enterModal(JumpToMode.direction, '"')

                JumpToMode.triggerDirectionIfSet()
            end,
        })
    end,

    doubleQuote = function()
        Pending.run({
            function()
                JumpToMode.actions.destroy()
            end,
            function()
                JumpToMode.enterModal(JumpToMode.direction, '"')

                JumpToMode.triggerDirectionIfSet()
            end,
        })
    end,

    backTick = function()
        JumpToMode.enterModal(JumpToMode.direction, "`")

        JumpToMode.triggerDirectionIfSet()
    end,

    parenthesis = function()
        Pending.run({
            function()
                JumpToMode.enterModal(JumpToMode.direction, "(")

                JumpToMode.triggerDirectionIfSet()
            end,
            function()
                JumpToMode.enterModal(JumpToMode.direction, ")")

                JumpToMode.triggerDirectionIfSet()
            end,
        })
    end,

    braces = function()
        Pending.run({
            function()
                JumpToMode.enterModal(JumpToMode.direction, "{")

                JumpToMode.triggerDirectionIfSet()
            end,
            function()
                JumpToMode.enterModal(JumpToMode.direction, "}")

                JumpToMode.triggerDirectionIfSet()
            end,
        })
    end,

    brackets = function()
        Pending.run({
            function()
                JumpToMode.enterModal(JumpToMode.direction, "[")

                JumpToMode.triggerDirectionIfSet()
            end,
            function()
                JumpToMode.enterModal(JumpToMode.direction, "]")

                JumpToMode.triggerDirectionIfSet()
            end
        })
    end,

    backward = function()
        if not TextManipulation.canManipulateWithVim() then
            return Modal.exit()
        end

        JumpToMode.enterModal('B', JumpToMode.key)

        if not JumpToMode.key then
            return
        end

        JumpToMode.beginJumpingBackward()
        JumpToMode.keymap[JumpToMode.key]()
    end,

    forward = function()
        if not TextManipulation.canManipulateWithVim() then
            return Modal.exit()
        end

        JumpToMode.enterModal('F', JumpToMode.key)

        if not JumpToMode.key then
            return
        end

        JumpToMode.beginJumpingForward()
        JumpToMode.keymap[JumpToMode.key]()
    end,
}

JumpToMode.keymap = {
    ["'"] = function()
        fastKeyStroke("'")
    end,
    ['"'] = function()
        fastKeyStroke({'shift'}, "'")
    end,
    ["`"] = function()
        fastKeyStroke({'alt'}, "`")
    end,
    ['('] = function()
        fastKeyStroke({'shift'}, "9")
    end,
    [')'] = function()
        fastKeyStroke({'shift'}, "0")
    end,
    ['{'] = function()
        fastKeyStroke({'shift'}, "[")
    end,
    ['}'] = function()
        fastKeyStroke({'shift'}, "]")
    end,
    ['['] = function()
        fastKeyStroke("[")
    end,
    [']'] = function()
        fastKeyStroke("]")
    end,
}

function JumpToMode.mode()
    JumpToMode.enterModal()
end

function JumpToMode.modeBackward()
    JumpToMode.enterModal('B')
end

function JumpToMode.singleQuote()
    JumpToMode.enterModal('F')
    JumpToMode.actions.singleQuote()
end

function JumpToMode.doubleQuote()
    JumpToMode.enterModal('F')
    JumpToMode.actions.doubleQuote()
end

function JumpToMode.backTick()
    JumpToMode.enterModal('F')
    JumpToMode.actions.backTick()
end

function JumpToMode.parenthesis()
    JumpToMode.enterModal('F')
    JumpToMode.actions.parenthesis()
end

function JumpToMode.braces()
    JumpToMode.enterModal('F')
    JumpToMode.actions.braces(true)
end

function JumpToMode.brackets()
    JumpToMode.enterModal('F')
    JumpToMode.actions.brackets()
end

function JumpToMode.previousBlock()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke({'shift'}, '[')
    else
        fastKeyStroke({'shift', 'cmd'}, 'left')
    end
end

return JumpToMode
