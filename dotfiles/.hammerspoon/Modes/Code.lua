local CodeMode = {}
CodeMode.__index = CodeMode

CodeMode.lookup = {
    y = 'conditionalAnd',
    u = 'addUseStatement',
    i = 'multipleCursorsUp',
    o = 'concatenate',
    p = 'conditionalOr',
    open_bracket = 'fold',
    close_bracket = 'unfold',
    h = 'selectAll',
    j = 'moveLineDown',
    k = 'moveLineUp',
    l = 'goToDefinition',
    semicolon = 'toggleSemicolon',
    quote = 'equals',
    return_or_enter = 'typeReturn',
    n = 'selectNextWord',
    m = 'multipleCursorsDown',
    comma = 'toggleComma',
    period = 'doubleArrow',
    slash = 'goToMatchingBracket',
    right_shift = nil,
    spacebar = 'comment',
}

function CodeMode.conditionalAnd()
    if titleContains('.lua') then
        insertText(' and ')
    else
        insertText(' && ')
    end
end

function CodeMode.addUseStatement()
    fastKeyStroke({'ctrl', 'alt'}, 'u')
end

function CodeMode.multipleCursorsUp()
    handleApp(fastKeyStroke, {
        [atom] = {{'shift', 'ctrl'}, 'up'},
        [sublime] = {{'shift', 'ctrl', 'alt'}, 'up'},
    })
    -- handleApp({
    --     [atom] = _(fastKeyStroke, {'shift', 'ctrl'}, 'up'),
    --     [sublime] = _(fastKeyStroke, {'shift', 'ctrl', 'alt'}, 'up'),
    -- })
end

function CodeMode.conditionalOr()
    handleConditional(titleContains, insertText, {
        {condition = '.lua', value = ' or '},
        {condition = 'fallback', value = ' || '},
        -- ['.lua'] = ' or ',
        -- ['fallback'] = ' || ',
    })
    -- if titleContains('.lua') then
    --     insertText(' or ')
    -- else
    --     insertText(' || ')
    -- end
end

function CodeMode.fold()
    fastKeyStroke({'alt', 'cmd'}, '[')
end

function CodeMode.unfold()
    fastKeyStroke({'alt', 'cmd'}, ']')
end

function CodeMode.moveLineDown()
    if appIs(notion) then
        fastKeyStroke({'shift', 'cmd'}, 'down')
    elseif appIs(atom) or appIs(sublime) then
        -- Atom, Sublime: Move line down
        fastKeyStroke({'ctrl', 'cmd'}, 'down')
    end
end

function CodeMode.moveLineUp()
    if appIs(notion) then
        fastKeyStroke({'shift', 'cmd'}, 'up')
        fastKeyStroke({'shift', 'cmd'}, 'up')
    elseif appIs(atom) or appIs(sublime) then
        fastKeyStroke({'ctrl', 'cmd'}, 'up')
    end
end

function CodeMode.goToDefinition()
    fastKeyStroke({'alt', 'cmd'}, 'down')
end

function CodeMode.toggleSemicolon()
    if inCodeEditor() then
        return fastKeyStroke({'alt'}, ';')
    end

    md.Vi.moveToEndOfLine()
    fastKeyStroke({'shift'}, 'left')
    text = getSelectedText()

    if getSelectedText() == ';' then
        fastKeyStroke('delete')
    else
        fastKeyStroke('right')
        insertText(';')
    end
end

function CodeMode.equals()
    Pending.run({
        function()
            insertText(' = ')
            BracketMatching.start()
        end,
        function()
            insertText(' == ')
            BracketMatching.start()
        end,
        function()
            if titleContains('.lua') then
                insertText(' ~= ')
            else
                insertText(' != ')
            end

            BracketMatching.start()
        end,
    })
end

function CodeMode.typeReturn()
    insertText('return')
end

function CodeMode.toggleBoolean()
    handleApp({
        [atom] = _(fastKeyStroke, '-'),
        [sublime] = _(fastKeyStroke, {'alt', 'cmd'}, 'x'),
    })
end

function CodeMode.selectNextWord()
    fastKeyStroke({'cmd'}, 'd')
end

function CodeMode.multipleCursorsDown()
    fastKeyStroke({'shift', 'ctrl', 'alt'}, 'down')
end

function CodeMode.toggleComma()
    if inCodeEditor() then
        return fastKeyStroke({'alt'}, ',')
    end

    md.Vi.moveToEndOfLine()
    fastKeyStroke({'shift'}, 'left')
    text = getSelectedText()

    if getSelectedText() == ',' then
        fastKeyStroke('delete')
    else
        fastKeyStroke('right')
        insertText(',')
    end
end

function CodeMode.doubleArrow()
    insertText(' => ')
    BracketMatching.start()
end

function CodeMode.goToMatchingBracket()
    fastKeyStroke({'ctrl'}, 'm')
end

function CodeMode.comment()
    fastKeyStroke({'cmd'}, '/')
end

function CodeMode.concatenate()
    if titleContains('.php') then
        insertText(' . ')
    elseif titleContains('.lua') then
        insertText(' .. ')
    elseif titleContains('.js') then
        insertText(' + ')
    end

    BracketMatching.start()
end

function CodeMode.selectAll()
    fastKeyStroke({'ctrl', 'cmd'}, 'g')
end

return CodeMode
