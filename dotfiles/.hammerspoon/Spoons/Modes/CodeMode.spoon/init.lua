local CodeMode = {}
CodeMode.__index = CodeMode

GitMode = hs.loadSpoon('Modes/GitMode')

CodeMode.lookup = {
    y = 'conditionalAnd',
    u = 'addUseStatement',
    i = 'multipleCursorsUp',
    o = nil,
    p = 'conditionalOr',
    open_bracket = 'fold',
    close_bracket = 'unfold',
    h = nil,
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

    b = 'toggleBoolean',
}

function CodeMode.handle(key)
    if appIs(iterm) then
        GitMode.handle(key)
    elseif CodeMode.lookup[key] then
        CodeMode[CodeMode.lookup[key]]()
    end
end

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
    if appIs(atom) then
        fastKeyStroke({'shift', 'ctrl'}, 'up')
    elseif appIs(sublime) then
        fastKeyStroke({'shift', 'ctrl', 'alt'}, 'up')
    end
end

function CodeMode.conditionalOr()
    if titleContains('.lua') then
        insertText(' or ')
    else
        insertText(' || ')
    end
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
    Pending.run({
        function()
            fastKeyStroke({'alt', 'cmd'}, 'down')
        end,
        function()
            spoon.YankMode.word()
            goToFileInAtom(hs.pasteboard.getContents())
        end,
    })
end

function CodeMode.toggleSemicolon()
    fastKeyStroke({'alt'}, ';')
end

function CodeMode.equals()
    Pending.run({
        function()
            insertText(' = ')
        end,
        function()
            insertText(' == ')
        end,
        function()
            if titleContains('.lua') then
                insertText(' ~= ')
            else
                insertText(' != ')
            end
        end,
    })
end

function CodeMode.typeReturn()
    insertText('return')
end

function CodeMode.toggleBoolean()
    if appIs(sublime) then
        fastKeyStroke({'alt', 'cmd'}, 'x')
    elseif appIs(atom) then
        fastKeyStroke('-')
    end
end

function CodeMode.selectNextWord()
    fastKeyStroke({'cmd'}, 'd')
end

function CodeMode.multipleCursorsDown()
    fastKeyStroke({'shift', 'ctrl', 'alt'}, 'down')
end

function CodeMode.toggleComma()
    fastKeyStroke({'alt'}, ',')
end

function CodeMode.doubleArrow()
    insertText(' => ')
end

function CodeMode.goToMatchingBracket()
    fastKeyStroke({'ctrl'}, 'm')
end

function CodeMode.comment()
    fastKeyStroke({'cmd'}, '/')
end

return CodeMode
