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
        fastKeyStroke('escape')
        fastKeyStroke('v')
        fastKeyStroke('e')
    else
        fastKeyStroke({'shift', 'alt'}, 'right')
    end
end

function SelectUntil.nextWord()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('v')
        fastKeyStroke('w')
    else
        fastKeyStroke({'shift', 'alt'}, 'right')
        fastKeyStroke({'shift', 'alt'}, 'right')
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
    callback = function(action)
        SelectUntil.actions[action]()
    end,
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
        fastKeyStroke({'ctrl'}, 'v')
    elseif appIs(atom) then
        fastKeyStroke({'ctrl', 'alt', 'cmd'}, 'v')
        fastKeyStroke('l')
    elseif appIs(sublime) then
        fastKeyStroke({'ctrl', 'alt', 'cmd'}, 'v')
    end
end

function SelectUntil.beginSelectingBackward()
    if not TextManipulation.canManipulateWithVim() then
        return
    end

    if appIs(vscode) then
        fastKeyStroke({'ctrl'}, 'v')
    elseif inCodeEditor() then
        fastKeyStroke({'ctrl', 'alt', 'cmd'}, 'v')
        fastKeyStroke('h')
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
        SelectUntil.enterModal(SelectUntil.direction, "`")
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
        fastKeyStroke({'shift'}, 't')
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
        fastKeyStroke('t')
        SelectUntil.keymap[SelectUntil.key]()
    end,

    change = function()
        Modal.exit()

        if TextManipulation.canManipulateWithVim() then
            fastKeyStroke('c')
        end

        BracketMatching.start()
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

SelectUntil.keymap = {
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
        fastKeyStroke('escape')
        fastKeyStroke({'shift', 'cmd'}, 'right')
    else
        fastKeyStroke({'shift', 'cmd'}, 'right')
    end
end

function SelectUntil.beginningOfLine()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')

        if appIs(vscode) then
            fastKeyStroke('v')
            fastKeyStroke({'shift'}, '6')
        else
            fastKeyStroke('right')
            fastKeyStroke({'shift', 'cmd'}, 'left')
        end
    else
        fastKeyStroke({'shift', 'cmd'}, 'left')
    end
end

function SelectUntil.previousBlock()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke({'shift'}, 'v')
        fastKeyStroke({'shift'}, '[')
    else
        fastKeyStroke({'shift', 'cmd'}, 'left')
    end
end

function SelectUntil.untilForward()
    fastKeyStroke('escape')
    fastKeyStroke('v')
    fastKeyStroke('t')
end

function SelectUntil.untilBackward()
    fastKeyStroke('escape')
    fastKeyStroke('v')
    fastKeyStroke({'shift'}, 't')
end

return SelectUntil
