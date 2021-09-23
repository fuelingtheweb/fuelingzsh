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
    left_shift = 'modeSecondary',
    z = 'backTick',
    x = nil,
    c = 'braces',
    v = nil,
    b = 'brackets',
    spacebar = nil,
}

JumpToMode.secondary = false
JumpToMode.direction = nil
JumpToMode.key = nil

Modal.add({
    key = 'JumpToMode',
    title = function()
        return 'Jump to: ' .. (JumpToMode.direction or '') .. ' ' .. (JumpToMode.key or '')
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
        JumpToMode.actions[action]()
    end,
    exited = function()
        JumpToMode.secondary = false
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

    JumpToMode.secondary = false

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
        JumpToMode.enterModal(JumpToMode.direction, "'")
        JumpToMode.triggerDirectionIfSet()
    end,

    doubleQuote = function()
        JumpToMode.enterModal(JumpToMode.direction, '"')
        JumpToMode.triggerDirectionIfSet()
    end,

    backTick = function()
        JumpToMode.enterModal(JumpToMode.direction, "`")
        JumpToMode.triggerDirectionIfSet()
    end,

    parenthesis = function()
        local character = JumpToMode.secondary and ')' or '('

        JumpToMode.enterModal(JumpToMode.direction, character)
        JumpToMode.triggerDirectionIfSet()
    end,

    braces = function()
        local character = JumpToMode.secondary and '}' or '{'

        JumpToMode.enterModal(JumpToMode.direction, character)
        JumpToMode.triggerDirectionIfSet()
    end,

    brackets = function()
        local character = JumpToMode.secondary and ']' or '['

        JumpToMode.enterModal(JumpToMode.direction, character)
        JumpToMode.triggerDirectionIfSet()
    end,

    secondaryParenthesis = function()
        JumpToMode.enterModal(JumpToMode.direction, ')')
        JumpToMode.triggerDirectionIfSet()
    end,

    secondaryBraces = function()
        JumpToMode.enterModal(JumpToMode.direction, '}')
        JumpToMode.triggerDirectionIfSet()
    end,

    secondaryBrackets = function()
        JumpToMode.enterModal(JumpToMode.direction, ']')
        JumpToMode.triggerDirectionIfSet()
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

function JumpToMode.modeSecondary()
    JumpToMode.secondary = true
    JumpToMode.enterModal('F')
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
