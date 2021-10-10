local JumpTo = {}
JumpTo.__index = JumpTo

JumpTo.lookup = {
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
    left_shift = 'modeSecondary',
    z = 'backTick',
    x = nil,
    c = 'braces',
    v = nil,
    b = 'brackets',
    spacebar = nil,
}

JumpTo.secondary = false
JumpTo.direction = nil
JumpTo.key = nil

Modal.add({
    key = 'JumpTo',
    title = function()
        return 'Jump to: ' .. (JumpTo.direction or '') .. ' ' .. (JumpTo.key or '')
    end,
    defaults = false,
    items = {
        ['s'] = 'singleQuote',
        ['d'] = 'doubleQuote',
        ['z'] = 'backTick',
        ['f'] = 'parenthesis',
        ['c'] = 'braces',
        ['b'] = 'brackets',
        {shift = true, key = 'f', value = 'secondaryParenthesis'},
        {shift = true, key = 'c', value = 'secondaryBraces'},
        {shift = true, key = 'b', value = 'secondaryBrackets'},
        [','] = 'backward',
        [';'] = 'forward',
    },
    callback = function(action)
        JumpTo.actions[action]()
    end,
    exited = function()
        if not JumpTo.paused then
            JumpTo.secondary = false
            JumpTo.direction = nil
            JumpTo.key = nil
        end
    end,
})

function JumpTo.triggerDirectionIfSet()
    if not JumpTo.direction then
        return
    end

    if JumpTo.direction == 'F' then
        action = 'forward'
    else
        action = 'backward'
    end
    JumpTo.actions[action]()

    JumpTo.secondary = false

    Modal.exit()
end

function JumpTo.enterModal(direction, key)
    JumpTo.direction = direction or nil
    JumpTo.key = key or nil
    Modal.enter('JumpTo')
end

function JumpTo.beginJumpingForward()
    if not TextManipulation.canManipulateWithVim() then
        return
    end

    if inCodeEditor() then
        fastKeyStroke('l')

        JumpTo.paused = true;
        Modal.exit('JumpTo')

        fastKeyStroke('f')

        Modal.enter('JumpTo')
        JumpTo.paused = false;
    end
end

function JumpTo.beginJumpingBackward()
    if not TextManipulation.canManipulateWithVim() then
        return
    end

    if inCodeEditor() then
        fastKeyStroke('h')
        fastKeyStroke({'shift'}, 't')
    end
end

JumpTo.actions = {
    singleQuote = function()
        JumpTo.enterModal(JumpTo.direction, "'")
        JumpTo.triggerDirectionIfSet()
    end,

    doubleQuote = function()
        JumpTo.enterModal(JumpTo.direction, '"')
        JumpTo.triggerDirectionIfSet()
    end,

    backTick = function()
        JumpTo.enterModal(JumpTo.direction, "`")
        JumpTo.triggerDirectionIfSet()
    end,

    parenthesis = function()
        local character = JumpTo.secondary and ')' or '('

        JumpTo.enterModal(JumpTo.direction, character)
        JumpTo.triggerDirectionIfSet()
    end,

    braces = function()
        local character = JumpTo.secondary and '}' or '{'

        JumpTo.enterModal(JumpTo.direction, character)
        JumpTo.triggerDirectionIfSet()
    end,

    brackets = function()
        local character = JumpTo.secondary and ']' or '['

        JumpTo.enterModal(JumpTo.direction, character)
        JumpTo.triggerDirectionIfSet()
    end,

    secondaryParenthesis = function()
        JumpTo.enterModal(JumpTo.direction, ')')
        JumpTo.triggerDirectionIfSet()
    end,

    secondaryBraces = function()
        JumpTo.enterModal(JumpTo.direction, '}')
        JumpTo.triggerDirectionIfSet()
    end,

    secondaryBrackets = function()
        JumpTo.enterModal(JumpTo.direction, ']')
        JumpTo.triggerDirectionIfSet()
    end,

    backward = function()
        if not TextManipulation.canManipulateWithVim() then
            return Modal.exit()
        end

        JumpTo.enterModal('B', JumpTo.key)

        if not JumpTo.key then
            return
        end

        JumpTo.beginJumpingBackward()
        JumpTo.keymap[JumpTo.key]()
    end,

    forward = function()
        if not TextManipulation.canManipulateWithVim() then
            return Modal.exit()
        end

        JumpTo.enterModal('F', JumpTo.key)

        if not JumpTo.key then
            return
        end

        JumpTo.beginJumpingForward()
        JumpTo.keymap[JumpTo.key]()
    end,
}

JumpTo.keymap = {
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

function JumpTo.mode()
    JumpTo.enterModal()
end

function JumpTo.modeBackward()
    JumpTo.enterModal('B')
end

function JumpTo.modeSecondary()
    JumpTo.secondary = true
    JumpTo.enterModal('F')
end

function JumpTo.singleQuote()
    JumpTo.enterModal('F')
    JumpTo.actions.singleQuote()
end

function JumpTo.doubleQuote()
    JumpTo.enterModal('F')
    JumpTo.actions.doubleQuote()
end

function JumpTo.backTick()
    JumpTo.enterModal('F')
    JumpTo.actions.backTick()
end

function JumpTo.parenthesis()
    JumpTo.enterModal('F')
    JumpTo.actions.parenthesis()
end

function JumpTo.braces()
    JumpTo.enterModal('F')
    JumpTo.actions.braces(true)
end

function JumpTo.brackets()
    JumpTo.enterModal('F')
    JumpTo.actions.brackets()
end

function JumpTo.previousBlock()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke({'shift'}, '[')
    else
        fastKeyStroke({'shift', 'cmd'}, 'left')
    end
end

return JumpTo
