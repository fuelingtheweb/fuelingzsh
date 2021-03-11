local SelectUntilMode = {}
SelectUntilMode.__index = SelectUntilMode

SelectUntilMode.lookup = {
    e = 'endOfWord',
    w = 'next-word',
    s = 'single-quote',
    d = 'double-quote',
    z = 'back-tick',
    caps_lock = 'mode',
    left_shift = 'mode-backward',
    f = 'parenthesis',
    c = 'braces',
    b = 'brackets',
    a = 'endOfLine',
    g = 'beginningOfLine',
    t = 'previousBlock',
}

function SelectUntilMode.handle(key)
    if SelectUntilMode.lookup[key] then
        hs.execute("open -g 'hammerspoon://select-until-" .. SelectUntilMode.lookup[key] .. "'")
    end
end

hs.urlevent.bind('select-until-endOfWord', function()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('v')
        fastKeyStroke('e')
    else
        fastKeyStroke({'shift', 'alt'}, 'right')
    end
end)

hs.urlevent.bind('select-until-nextWord', function()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('v')
        fastKeyStroke('w')
    else
        fastKeyStroke({'shift', 'alt'}, 'right')
        fastKeyStroke({'shift', 'alt'}, 'right')
    end
end)

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

SelectUntilMode.actions = {
    singleQuote = function()
        SelectUntilMode.enterModal(SelectUntilMode.direction, "'")

        SelectUntilMode.triggerDirectionIfSet()
    end,

    doubleQuote = function()
        SelectUntilMode.enterModal(SelectUntilMode.direction, '"')

        SelectUntilMode.triggerDirectionIfSet()
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

    braces = function()
        Pending.run({
            function()
                SelectUntilMode.enterModal(SelectUntilMode.direction, "{")

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

        if inCodeEditor() then
            fastKeyStroke({'ctrl', 'alt', 'cmd'}, 'v')
            fastKeyStroke('h')
        end

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

        if appIs(atom) then
            fastKeyStroke({'ctrl', 'alt', 'cmd'}, 'v')
            fastKeyStroke('l')
        elseif appIs(sublime) then
            fastKeyStroke({'ctrl', 'alt', 'cmd'}, 'v')
        end

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

hs.urlevent.bind('select-until-mode', function()
    SelectUntilMode.enterModal()
end)

hs.urlevent.bind('select-until-mode-backward', function()
    SelectUntilMode.enterModal('B')
end)

hs.urlevent.bind('select-until-single-quote', function()
    SelectUntilMode.enterModal('F')
    SelectUntilMode.actions.singleQuote()
end)

hs.urlevent.bind('select-until-double-quote', function()
    SelectUntilMode.enterModal('F')
    SelectUntilMode.actions.doubleQuote()
end)

hs.urlevent.bind('select-until-back-tick', function()
    SelectUntilMode.enterModal('F')
    SelectUntilMode.actions.backTick()
end)

hs.urlevent.bind('select-until-parenthesis', function()
    SelectUntilMode.enterModal('F')
    SelectUntilMode.actions.parenthesis()
end)

hs.urlevent.bind('select-until-braces', function()
    SelectUntilMode.enterModal('F')
    SelectUntilMode.actions.braces()
end)

hs.urlevent.bind('select-until-brackets', function()
    SelectUntilMode.enterModal('F')
    SelectUntilMode.actions.brackets()
end)

hs.urlevent.bind('select-until-endOfLine', function()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke({'shift', 'cmd'}, 'right')
    else
        fastKeyStroke({'shift', 'cmd'}, 'right')
    end
end)

hs.urlevent.bind('select-until-beginningOfLine', function()
    SelectUntilMode.beginningOfLine()
end)

function SelectUntilMode.beginningOfLine()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('right')
        fastKeyStroke({'shift', 'cmd'}, 'left')
    else
        fastKeyStroke({'shift', 'cmd'}, 'left')
    end
end

hs.urlevent.bind('select-until-previousBlock', function()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke({'shift'}, 'v')
        fastKeyStroke({'shift', 'ctrl', 'alt', 'cmd'}, 'v')
        fastKeyStroke({'shift'}, '[')
    else
        fastKeyStroke({'shift', 'cmd'}, 'left')
    end
end)

return SelectUntilMode
