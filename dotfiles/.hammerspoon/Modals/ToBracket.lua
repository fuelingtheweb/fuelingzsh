local ToBracket = {}
ToBracket.__index = ToBracket

ToBracket.action = nil
ToBracket.secondary = false
ToBracket.direction = nil
ToBracket.key = nil
ToBracket.paused = false

ToBracket.keymap = {
    ["'"] = function() ks.key("'") end,
    ['"'] = function() ks.shift("'") end,
    ['`'] = function() ks.alt('`') end,
    ['('] = function() ks.shift('9') end,
    [')'] = function() ks.shift('0') end,
    ['{'] = function() ks.shift('[') end,
    ['}'] = function() ks.shift(']') end,
    ['['] = function() ks.key('[') end,
    [']'] = function() ks.key(']') end
}

Modal.add({
    key = 'ToBracket',
    title = function()
        return (ToBracket.action == 'to' and 'Jump to' or 'Select until') .. ' Bracket: ' .. (ToBracket.direction or '') .. ' ' .. (ToBracket.key or '')
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
        ['n'] = 'change',
        ['y'] = 'yank',
        ['p'] = 'paste',
        ['m'] = 'destroy',
    },
    callback = function(item)
        if is.String(item) then
            ToBracket.actions[item]()
        else
            ToBracket.actions[item.value]()
        end
    end,
    exited = function()
        if not ToBracket.paused then
            ToBracket.action = nil
            ToBracket.secondary = false
            ToBracket.direction = nil
            ToBracket.key = nil
        end
    end,
})

ToBracket.actions = {
    singleQuote = function()
        ToBracket.enterModal(ToBracket.direction, "'")
        ToBracket.triggerDirectionIfSet()
    end,

    doubleQuote = function()
        ToBracket.enterModal(ToBracket.direction, '"')
        ToBracket.triggerDirectionIfSet()
    end,

    backTick = function()
        ToBracket.enterModal(ToBracket.direction, '`')
        ToBracket.triggerDirectionIfSet()
    end,

    parenthesis = function()
        local character = ToBracket.secondary and ')' or '('

        ToBracket.enterModal(ToBracket.direction, character)
        ToBracket.triggerDirectionIfSet()
    end,

    braces = function()
        local character = ToBracket.secondary and '}' or '{'

        ToBracket.enterModal(ToBracket.direction, character)
        ToBracket.triggerDirectionIfSet()
    end,

    brackets = function()
        local character = ToBracket.secondary and ']' or '['

        ToBracket.enterModal(ToBracket.direction, character)
        ToBracket.triggerDirectionIfSet()
    end,

    secondaryParenthesis = function()
        ToBracket.enterModal(ToBracket.direction, ')')
        ToBracket.triggerDirectionIfSet()
    end,

    secondaryBraces = function()
        ToBracket.enterModal(ToBracket.direction, '}')
        ToBracket.triggerDirectionIfSet()
    end,

    secondaryBrackets = function()
        ToBracket.enterModal(ToBracket.direction, ']')
        ToBracket.triggerDirectionIfSet()
    end,

    backward = function()
        if is.notVimMode() then
            return Modal.exit()
        end

        ToBracket.enterModal('B', ToBracket.key)

        if not ToBracket.key then
            return
        end

        if ToBracket.action == 'to' then
            ToBracket.beginJumpingBackward()
        elseif ToBracket.action == 'select' then
            ToBracket.beginSelectingBackward()
        end

        ToBracket.keymap[ToBracket.key]()
    end,

    forward = function()
        if is.notVimMode() then
            return Modal.exit()
        end

        ToBracket.enterModal('F', ToBracket.key)

        if not ToBracket.key then
            return
        end

        if ToBracket.action == 'to' then
            ToBracket.beginJumpingForward()
        elseif ToBracket.action == 'select' then
            ToBracket.beginSelectingForward()
        end

        ToBracket.keymap[ToBracket.key]()
    end,

    change = function()
        Modal.exit()

        if is.vimMode() then
            ks.key('c')
        end
    end,

    yank = function()
        Modal.exit()

        if is.vimMode() then
            ks.key('y')
        end
    end,

    paste = function()
        Modal.exit()

        if is.vimMode() then
            ks.key('p')
        end
    end,

    destroy = function()
        Modal.exit()

        if is.vimMode() then
            ks.key('d')
        end
    end,
}

function ToBracket.enterModal(direction, key)
    ToBracket.direction = direction or nil
    ToBracket.key = key or nil
    Modal.enter('ToBracket')
end

function ToBracket.triggerDirectionIfSet()
    if not ToBracket.direction then
        return
    end

    local action

    if ToBracket.direction == 'F' then
        action = 'forward'
    else
        action = 'backward'
    end

    ToBracket.actions[action]()

    ToBracket.secondary = false

    if ToBracket.action == 'to' then
        Modal.exit()
    end
end

function ToBracket.to()
    ToBracket.action = 'to'
    ToBracket.enterModal()
end

function ToBracket.toForward()
    ToBracket.action = 'to'
    ToBracket.enterModal('F')
end

function ToBracket.toBackward()
    ToBracket.action = 'to'
    ToBracket.enterModal('B')
end

function ToBracket.toSecondary()
    ToBracket.action = 'to'
    ToBracket.secondary = true
    ToBracket.enterModal('F')
end

function ToBracket.select()
    ToBracket.action = 'select'
    ToBracket.enterModal()
end

function ToBracket.selectForward()
    ToBracket.action = 'select'
    ToBracket.enterModal('F')
end

function ToBracket.selectBackward()
    ToBracket.action = 'select'
    ToBracket.enterModal('B')
end

function ToBracket.selectSecondary()
    ToBracket.action = 'select'
    ToBracket.secondary = true
    ToBracket.enterModal('F')
end

function ToBracket.beginJumpingForward()
    if is.notVimMode() then
        return
    end

    if is.codeEditor() then
        ks.key('l')

        ToBracket.paused = true
        Modal.exit('ToBracket')

        ks.key('f')

        Modal.enter('ToBracket')
        ToBracket.paused = false
    end
end

function ToBracket.beginJumpingBackward()
    if is.notVimMode() then
        return
    end

    if is.codeEditor() then
        ks.key('h').shift('t')
    end
end

function ToBracket.beginSelectingForward()
    cm.ViVisual.beginSelectingForward()
    ks.key('t')
end

function ToBracket.beginSelectingBackward()
    cm.ViVisual.beginSelectingBackward()
    ks.shift('t')
end

return ToBracket
