local SelectUntilMode = {}
SelectUntilMode.__index = SelectUntilMode

SelectUntilMode.lookup = {
    tab = nil,
    q = nil,
    w = 'nextWord',
    e = 'endOfWord',
    r = nil,
    t = 'previousBlock',
    caps_lock = 'mode',
    a = 'endOfLine',
    s = 'singleQuote',
    d = 'doubleQuote',
    f = 'parenthesis',
    g = 'beginningOfLine',
    left_shift = 'modeBackward',
    z = 'backTick',
    x = nil,
    c = 'braces',
    v = nil,
    b = 'brackets',
    spacebar = nil,
}

function SelectUntilMode.endOfWord()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('v')
        fastKeyStroke('e')
    else
        fastKeyStroke({'shift', 'alt'}, 'right')
    end
end

function SelectUntilMode.nextWord()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('v')
        fastKeyStroke('w')
    else
        fastKeyStroke({'shift', 'alt'}, 'right')
        fastKeyStroke({'shift', 'alt'}, 'right')
    end
end

SelectUntilMode.direction = nil
SelectUntilMode.key = nil

Modal.addWithMenubar({
    key = 'SelectUntilMode',
    title = function()
        return 'Select Until: ' .. (SelectUntilMode.direction or '') .. ' ' .. (SelectUntilMode.key or '')
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
            {key = 'n', action = 'change'},
            {key = 'y', action = 'yank'},
            {key = 'p', action = 'paste'},
            {key = '[', action = 'destroy'},
        },
        callback = function(item)
            SelectUntilMode.actions[item.action]()
        end,
    },
    exited = function()
        SelectUntilMode.direction = nil
        SelectUntilMode.key = nil
    end,
})

function SelectUntilMode.triggerDirectionIfSet()
    if not SelectUntilMode.direction then
        return
    end

    if SelectUntilMode.direction == 'F' then
        action = 'forward'
    else
        action = 'backward'
    end
    SelectUntilMode.actions[action]()
end

function SelectUntilMode.enterModal(direction, key)
    SelectUntilMode.direction = direction or nil
    SelectUntilMode.key = key or nil
    Modal.enter('SelectUntilMode')
end

function SelectUntilMode.beginSelectingForward()
    if not TextManipulation.canManipulateWithVim() then
        return
    end

    if appIs(atom) then
        fastKeyStroke({'ctrl', 'alt', 'cmd'}, 'v')
        fastKeyStroke('l')
    elseif appIs(sublime) then
        fastKeyStroke({'ctrl', 'alt', 'cmd'}, 'v')
    end
end

function SelectUntilMode.beginSelectingBackward()
    if not TextManipulation.canManipulateWithVim() then
        return
    end

    if inCodeEditor() then
        fastKeyStroke({'ctrl', 'alt', 'cmd'}, 'v')
        fastKeyStroke('h')
    end
end

SelectUntilMode.actions = {
    singleQuote = function()
        Pending.run({
            function()
                SelectUntilMode.enterModal(SelectUntilMode.direction, "'")

                SelectUntilMode.triggerDirectionIfSet()
            end,
            function()
                SelectUntilMode.enterModal(SelectUntilMode.direction, '"')

                SelectUntilMode.triggerDirectionIfSet()
            end,
        })
    end,

    doubleQuote = function()
        Pending.run({
            function()
                SelectUntilMode.actions.destroy()
            end,
            function()
                SelectUntilMode.enterModal(SelectUntilMode.direction, '"')

                SelectUntilMode.triggerDirectionIfSet()
            end,
        })
    end,

    backTick = function()
        SelectUntilMode.enterModal(SelectUntilMode.direction, "`")

        SelectUntilMode.triggerDirectionIfSet()
    end,

    parenthesis = function()
        Pending.run({
            function()
                SelectUntilMode.enterModal(SelectUntilMode.direction, "(")

                SelectUntilMode.triggerDirectionIfSet()
            end,
            function()
                SelectUntilMode.enterModal(SelectUntilMode.direction, ")")

                SelectUntilMode.triggerDirectionIfSet()
            end,
        })
    end,

    braces = function(first)
        first = first or false
        Pending.run({
            function()
                if first then
                    SelectUntilMode.enterModal(SelectUntilMode.direction, "{")

                    return SelectUntilMode.triggerDirectionIfSet()
                end

                SelectUntilMode.actions.change()
            end,
            function()
                local key = "{"
                if first then
                    key = "}"
                end

                SelectUntilMode.enterModal(SelectUntilMode.direction, key)

                SelectUntilMode.triggerDirectionIfSet()
            end,
            function()
                SelectUntilMode.enterModal(SelectUntilMode.direction, "}")

                SelectUntilMode.triggerDirectionIfSet()
            end,
        })
    end,

    brackets = function()
        Pending.run({
            function()
                SelectUntilMode.enterModal(SelectUntilMode.direction, "[")

                SelectUntilMode.triggerDirectionIfSet()
            end,
            function()
                SelectUntilMode.enterModal(SelectUntilMode.direction, "]")

                SelectUntilMode.triggerDirectionIfSet()
            end
        })
    end,

    backward = function()
        if not TextManipulation.canManipulateWithVim() then
            return Modal.exit()
        end

        SelectUntilMode.enterModal('B', SelectUntilMode.key)

        if not SelectUntilMode.key then
            return
        end

        SelectUntilMode.beginSelectingBackward()
        fastKeyStroke({'shift'}, 'f')
        SelectUntilMode.keymap[SelectUntilMode.key]()
    end,

    forward = function()
        if not TextManipulation.canManipulateWithVim() then
            return Modal.exit()
        end

        SelectUntilMode.enterModal('F', SelectUntilMode.key)

        if not SelectUntilMode.key then
            return
        end

        SelectUntilMode.beginSelectingForward()
        fastKeyStroke('t')
        SelectUntilMode.keymap[SelectUntilMode.key]()
    end,

    change = function()
        Modal.exit()

        if TextManipulation.canManipulateWithVim() then
            fastKeyStroke('c')
        end
    end,

    yank = function()
        Modal.exit()

        if TextManipulation.canManipulateWithVim() then
            fastKeyStroke('y')
        end
    end,

    paste = function()
        Modal.exit()

        if TextManipulation.canManipulateWithVim() then
            fastKeyStroke('p')
        end
    end,

    destroy = function()
        Modal.exit()

        if TextManipulation.canManipulateWithVim() then
            fastKeyStroke('d')
        end
    end,
}

SelectUntilMode.keymap = {
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

function SelectUntilMode.mode()
    SelectUntilMode.enterModal()
end

function SelectUntilMode.modeBackward()
    SelectUntilMode.enterModal('B')
end

function SelectUntilMode.singleQuote()
    SelectUntilMode.enterModal('F')
    SelectUntilMode.actions.singleQuote()
end

function SelectUntilMode.doubleQuote()
    SelectUntilMode.enterModal('F')
    SelectUntilMode.actions.doubleQuote()
end

function SelectUntilMode.backTick()
    SelectUntilMode.enterModal('F')
    SelectUntilMode.actions.backTick()
end

function SelectUntilMode.parenthesis()
    SelectUntilMode.enterModal('F')
    SelectUntilMode.actions.parenthesis()
end

function SelectUntilMode.braces()
    SelectUntilMode.enterModal('F')
    SelectUntilMode.actions.braces(true)
end

function SelectUntilMode.brackets()
    SelectUntilMode.enterModal('F')
    SelectUntilMode.actions.brackets()
end

function SelectUntilMode.endOfLine()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke({'shift', 'cmd'}, 'right')
    else
        fastKeyStroke({'shift', 'cmd'}, 'right')
    end
end

function SelectUntilMode.beginningOfLine()
    SelectUntilMode.beginningOfLine()
end

function SelectUntilMode.beginningOfLine()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('right')
        fastKeyStroke({'shift', 'cmd'}, 'left')
    else
        fastKeyStroke({'shift', 'cmd'}, 'left')
    end
end

function SelectUntilMode.previousBlock()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke({'shift'}, 'v')
        fastKeyStroke({'shift', 'ctrl', 'alt', 'cmd'}, 'v')
        fastKeyStroke({'shift'}, '[')
    else
        fastKeyStroke({'shift', 'cmd'}, 'left')
    end
end

return SelectUntilMode
