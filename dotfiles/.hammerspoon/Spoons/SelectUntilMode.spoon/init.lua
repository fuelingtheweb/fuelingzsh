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
    i = 'beginningOfLine',
    t = 'previousBlock',
}

function SelectUntilMode.handle(key)
    if SelectUntilMode.lookup[key] then
        hs.execute("open -g 'hammerspoon://select-until-" .. SelectUntilMode.lookup[key] .. "'")
    end
end

hs.urlevent.bind('select-until-endOfWord', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'v', 0)
        hs.eventtap.keyStroke({}, 'e', 0)
    else
        hs.eventtap.keyStroke({'shift', 'alt'}, 'right', 0)
    end
end)

hs.urlevent.bind('select-until-nextWord', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'v', 0)
        hs.eventtap.keyStroke({}, 'w', 0)
    else
        hs.eventtap.keyStroke({'shift', 'alt'}, 'right', 0)
        hs.eventtap.keyStroke({'shift', 'alt'}, 'right', 0)
    end
end)

SelectUntilModal = hs.loadSpoon('SelectUntilModal')

local keys = {
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
}

function triggerDirectionIfSet()
    if not SelectUntilModal.direction then
        return
    end

    if SelectUntilModal.direction == 'F' then
        action = 'forward'
    else
        action = 'backward'
    end
    SelectUntilModal.actions[action]()
end

local actions = {
    singleQuote = function()
        SelectUntilModal:enter(SelectUntilModal.direction, "'")

        triggerDirectionIfSet()
    end,

    doubleQuote = function()
        SelectUntilModal:enter(SelectUntilModal.direction, '"')

        triggerDirectionIfSet()
    end,

    backTick = function()
        SelectUntilModal:enter(SelectUntilModal.direction, "`")

        triggerDirectionIfSet()
    end,

    parenthesis = function()
        if SelectUntilModal.pending then
            SelectUntilModal.timer:stop()
            SelectUntilModal.pending = false
            SelectUntilModal.pendingKey = nil
            SelectUntilModal:enter(SelectUntilModal.direction, ")")

            triggerDirectionIfSet()
        else
            SelectUntilModal.pending = true
            SelectUntilModal.pendingKey = "("
            SelectUntilModal.timer:start()
        end
    end,

    braces = function()
        if SelectUntilModal.pending then
            SelectUntilModal.timer:stop()
            SelectUntilModal.pending = false
            SelectUntilModal.pendingKey = nil
            SelectUntilModal:enter(SelectUntilModal.direction, "}")

            triggerDirectionIfSet()
        else
            SelectUntilModal.pending = true
            SelectUntilModal.pendingKey = "{"
            SelectUntilModal.timer:start()
        end
    end,

    brackets = function()
        if SelectUntilModal.pending then
            SelectUntilModal.timer:stop()
            SelectUntilModal.pending = false
            SelectUntilModal.pendingKey = nil
            SelectUntilModal:enter(SelectUntilModal.direction, "]")

            triggerDirectionIfSet()
        else
            SelectUntilModal.pending = true
            SelectUntilModal.pendingKey = "["
            SelectUntilModal.timer:start()
        end
    end,

    backward = function()
        if not TextManipulation.canManipulateWithVim() then
            return spoon.ModalMgr:deactivate({SelectUntilModal.modalKey})
        end

        SelectUntilModal:enter('B', SelectUntilModal.key)

        if not SelectUntilModal.key then
            return
        end

        if inCodeEditor() then
            hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 'v', 0)
            hs.eventtap.keyStroke({}, 'h', 0)
        end

        hs.eventtap.keyStroke({'shift'}, 'f', 0)

        SelectUntilModal.keymap[SelectUntilModal.key]()
    end,

    forward = function()
        if not TextManipulation.canManipulateWithVim() then
            return spoon.ModalMgr:deactivate({SelectUntilModal.modalKey})
        end

        SelectUntilModal:enter('F', SelectUntilModal.key)

        if not SelectUntilModal.key then
            return
        end

        if appIs(atom) then
            hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 'v', 0)
            hs.eventtap.keyStroke({}, 'l', 0)
        elseif appIs(sublime) then
            hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 'v', 0)
        end

        hs.eventtap.keyStroke({}, 't', 0)

        SelectUntilModal.keymap[SelectUntilModal.key]()
    end,

    change = function()
        spoon.ModalMgr:deactivate({SelectUntilModal.modalKey})

        if TextManipulation.canManipulateWithVim() then
            hs.eventtap.keyStroke({}, 'c', 0)
        end
    end,

    yank = function()
        spoon.ModalMgr:deactivate({SelectUntilModal.modalKey})

        if TextManipulation.canManipulateWithVim() then
            hs.eventtap.keyStroke({}, 'y', 0)
        end
    end,

    paste = function()
        spoon.ModalMgr:deactivate({SelectUntilModal.modalKey})

        if TextManipulation.canManipulateWithVim() then
            hs.eventtap.keyStroke({}, 'p', 0)
        end
    end,

    destroy = function()
        spoon.ModalMgr:deactivate({SelectUntilModal.modalKey})

        if TextManipulation.canManipulateWithVim() then
            hs.eventtap.keyStroke({}, 'd', 0)
        end
    end,
}

local keyMap = {
    ["'"] = function()
        hs.eventtap.keyStroke({}, "'", 0)
    end,
    ['"'] = function()
        hs.eventtap.keyStroke({'shift'}, "'", 0)
    end,
    ["`"] = function()
        hs.eventtap.keyStroke({'alt'}, "`", 0)
    end,
    ['('] = function()
        hs.eventtap.keyStroke({'shift'}, "9", 0)
    end,
    [')'] = function()
        hs.eventtap.keyStroke({'shift'}, "0", 0)
    end,
    ['{'] = function()
        hs.eventtap.keyStroke({'shift'}, "[", 0)
    end,
    ['}'] = function()
        hs.eventtap.keyStroke({'shift'}, "]", 0)
    end,
    ['['] = function()
        hs.eventtap.keyStroke({}, "[", 0)
    end,
    [']'] = function()
        hs.eventtap.keyStroke({}, "]", 0)
    end,
}

local timer = hs.timer.new(0.2, function()
    SelectUntilModal.timer:stop()
    SelectUntilModal.pending = false
    SelectUntilModal:enter(SelectUntilModal.direction, SelectUntilModal.pendingKey)

    triggerDirectionIfSet()
end)

SelectUntilModal:init(keys, actions, keyMap, timer)
SelectUntilModal:start()

hs.urlevent.bind('select-until-mode', function()
    SelectUntilModal:enter()
end)

hs.urlevent.bind('select-until-mode-backward', function()
    SelectUntilModal:enter('B')
end)

hs.urlevent.bind('select-until-single-quote', function()
    SelectUntilModal:enter('F')
    SelectUntilModal.actions.singleQuote()
end)

hs.urlevent.bind('select-until-double-quote', function()
    SelectUntilModal:enter('F')
    SelectUntilModal.actions.doubleQuote()
end)

hs.urlevent.bind('select-until-back-tick', function()
    SelectUntilModal:enter('F')
    SelectUntilModal.actions.backTick()
end)

hs.urlevent.bind('select-until-parenthesis', function()
    SelectUntilModal:enter('F')
    SelectUntilModal.actions.parenthesis()
end)

hs.urlevent.bind('select-until-braces', function()
    SelectUntilModal:enter('F')
    SelectUntilModal.actions.braces()
end)

hs.urlevent.bind('select-until-brackets', function()
    SelectUntilModal:enter('F')
    SelectUntilModal.actions.brackets()
end)

hs.urlevent.bind('select-until-endOfLine', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'right', 0)
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'right', 0)
    end
end)

hs.urlevent.bind('select-until-beginningOfLine', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'left', 0)
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'left', 0)
    end
end)

hs.urlevent.bind('select-until-previousBlock', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({'shift'}, 'v', 0)
        hs.eventtap.keyStroke({'shift', 'ctrl', 'alt', 'cmd'}, 'v', 0)
        hs.eventtap.keyStroke({'shift'}, '[', 0)
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'left', 0)
    end
end)

return SelectUntilMode
