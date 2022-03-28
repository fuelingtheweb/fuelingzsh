local SelectUntil = {}
SelectUntil.__index = SelectUntil

SelectUntil.lookup = {
    tab = 'untilBackward',
    q = nil,
    w = 'nextWord',
    e = 'endOfWord',
    r = 'untilForward',
    t = 'previousBlock',
    caps_lock = 'modeBackward',
    a = 'endOfLine',
    s = 'singleQuote',
    d = 'doubleQuote',
    f = 'parenthesis',
    g = 'beginningOfLine',
    left_shift = 'modeSecondary',
    z = 'backTick',
    x = nil,
    c = 'braces',
    v = nil,
    b = 'brackets',
    spacebar = nil,
}

function SelectUntil.endOfWord()
    if TextManipulation.canManipulateWithVim() then
        ks.escape().sequence({'v', 'e'})
    else
        ks.shiftAlt('right')
    end
end

function SelectUntil.nextWord()
    if TextManipulation.canManipulateWithVim() then
        ks.escape().sequence({'v', 'w'})
    else
        ks.shiftAlt('right').shiftAlt('right')
    end
end

SelectUntil.secondary = false
SelectUntil.direction = nil
SelectUntil.key = nil

Modal.add({
    key = 'SelectUntil',
    title = function()
        return 'Select Until: ' .. (SelectUntil.direction or '') .. ' ' .. (SelectUntil.key or '')
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
    callback = function(action) SelectUntil.actions[action]() end,
    exited = function()
        SelectUntil.secondary = false
        SelectUntil.direction = nil
        SelectUntil.key = nil
    end,
})

function SelectUntil.triggerDirectionIfSet()
    if not SelectUntil.direction then
        return
    end

    if SelectUntil.direction == 'F' then
        action = 'forward'
    else
        action = 'backward'
    end

    SelectUntil.actions[action]()

    SelectUntil.secondary = false
end

function SelectUntil.enterModal(direction, key)
    SelectUntil.direction = direction or nil
    SelectUntil.key = key or nil
    Modal.enter('SelectUntil')
end

function SelectUntil.beginSelectingForward()
    if not TextManipulation.canManipulateWithVim() then
        return
    end

    if appIs(vscode) then
        ks.ctrl('v')
    elseif appIs(atom) then
        ks.super('v').key('l')
    elseif appIs(sublime) then
        ks.super('v')
    end
end

function SelectUntil.beginSelectingBackward()
    if not TextManipulation.canManipulateWithVim() then
        return
    end

    if appIs(vscode) then
        ks.ctrl('v')
    elseif inCodeEditor() then
        ks.super('v').key('h')
    end
end

SelectUntil.actions = {
    singleQuote = function()
        SelectUntil.enterModal(SelectUntil.direction, "'")
        SelectUntil.triggerDirectionIfSet()
    end,

    doubleQuote = function()
        SelectUntil.enterModal(SelectUntil.direction, '"')
        SelectUntil.triggerDirectionIfSet()
    end,

    backTick = function()
        SelectUntil.enterModal(SelectUntil.direction, '`')
        SelectUntil.triggerDirectionIfSet()
    end,

    parenthesis = function()
        local character = SelectUntil.secondary and ')' or '('

        SelectUntil.enterModal(SelectUntil.direction, character)
        SelectUntil.triggerDirectionIfSet()
    end,

    braces = function()
        local character = SelectUntil.secondary and '}' or '{'

        SelectUntil.enterModal(SelectUntil.direction, character)
        SelectUntil.triggerDirectionIfSet()
    end,

    brackets = function()
        local character = SelectUntil.secondary and ']' or '['

        SelectUntil.enterModal(SelectUntil.direction, character)
        SelectUntil.triggerDirectionIfSet()
    end,

    secondaryParenthesis = function()
        SelectUntil.enterModal(SelectUntil.direction, ')')
        SelectUntil.triggerDirectionIfSet()
    end,

    secondaryBraces = function()
        SelectUntil.enterModal(SelectUntil.direction, '}')
        SelectUntil.triggerDirectionIfSet()
    end,

    secondaryBrackets = function()
        SelectUntil.enterModal(SelectUntil.direction, ']')
        SelectUntil.triggerDirectionIfSet()
    end,

    backward = function()
        if not TextManipulation.canManipulateWithVim() then
            return Modal.exit()
        end

        SelectUntil.enterModal('B', SelectUntil.key)

        if not SelectUntil.key then
            return
        end

        SelectUntil.beginSelectingBackward()
        ks.shift('t')
        SelectUntil.keymap[SelectUntil.key]()
    end,

    forward = function()
        if not TextManipulation.canManipulateWithVim() then
            return Modal.exit()
        end

        SelectUntil.enterModal('F', SelectUntil.key)

        if not SelectUntil.key then
            return
        end

        SelectUntil.beginSelectingForward()
        ks.key('t')
        SelectUntil.keymap[SelectUntil.key]()
    end,

    change = function()
        Modal.exit()

        if TextManipulation.canManipulateWithVim() then
            ks.key('c')
        end

        BracketMatching.start()
    end,

    yank = function()
        Modal.exit()

        if TextManipulation.canManipulateWithVim() then
            ks.key('y')
        end
    end,

    paste = function()
        Modal.exit()

        if TextManipulation.canManipulateWithVim() then
            ks.key('p')
        end
    end,

    destroy = function()
        Modal.exit()

        if TextManipulation.canManipulateWithVim() then
            ks.key('d')
        end
    end
}

SelectUntil.keymap = {
    ["'"] = function() ks.key("'") end,
    ['"'] = function() ks.shift("'") end,
    ['`'] = function() ks.alt('`') end,
    ['('] = function() ks.shift('9') end,
    [')'] = function() ks.shift('0') end,
    ['{'] = function() ks.shift('[') end,
    ['}'] = function() ks.shift(']') end,
    ['['] = function() ks.key('[') end,
    [']'] = function() ks.key(']') end,
}

function SelectUntil.mode()
    SelectUntil.enterModal()
end

function SelectUntil.modeBackward()
    SelectUntil.enterModal('B')
end

function SelectUntil.modeSecondary()
    SelectUntil.secondary = true
    SelectUntil.enterModal('F')
end

function SelectUntil.singleQuote()
    SelectUntil.enterModal('F')
    SelectUntil.actions.singleQuote()
end

function SelectUntil.doubleQuote()
    SelectUntil.enterModal('F')
    SelectUntil.actions.doubleQuote()
end

function SelectUntil.backTick()
    SelectUntil.enterModal('F')
    SelectUntil.actions.backTick()
end

function SelectUntil.parenthesis()
    SelectUntil.enterModal('F')
    SelectUntil.actions.parenthesis()
end

function SelectUntil.braces()
    SelectUntil.enterModal('F')
    SelectUntil.actions.braces(true)
end

function SelectUntil.brackets()
    SelectUntil.enterModal('F')
    SelectUntil.actions.brackets()
end

function SelectUntil.endOfLine()
    if TextManipulation.canManipulateWithVim() then
        ks.escape().shiftCmd('right')
    else
        ks.shiftCmd('right')
    end
end

function SelectUntil.beginningOfLine()
    if TextManipulation.canManipulateWithVim() then
        ks.escape()

        if appIs(vscode) then
            ks.key('v').shift('6')
        else
            ks.right().shiftCmd('left')
        end
    else
        ks.shiftCmd('left')
    end
end

function SelectUntil.previousBlock()
    if TextManipulation.canManipulateWithVim() then
        ks.shift('v').shift('[')
    else
        ks.shiftCmd('left')
    end
end

function SelectUntil.untilForward()
    ks.escape().sequence({'v', 't'})
end

function SelectUntil.untilBackward()
    ks.escape().key('v').shift('t')
end

return SelectUntil
