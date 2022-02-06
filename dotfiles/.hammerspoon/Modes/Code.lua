local Code = {}
Code.__index = Code

Code.lookup = {
    y = 'multipleCursorsUp',
    u = 'addUseStatement',
    i = 'focusBreadcrumbs',
    o = 'goToDefinition',
    p = nil,
    open_bracket = 'fold',
    close_bracket = 'unfold',
    h = 'previousMember',
    j = 'moveLineDown',
    k = 'moveLineUp',
    l = 'nextMember',
    semicolon = 'toggleSemicolon',
    quote = 'toggleBrackets',
    return_or_enter = 'selectAll',
    n = 'selectNextWord',
    m = 'multipleCursorsDown',
    comma = 'toggleComma',
    period = 'doubleArrow',
    slash = 'goToMatchingPair',
    right_shift = 'goToMatchingBracket',
    spacebar = 'comment'
}

function Code.addUseStatement() fastKeyStroke({'ctrl', 'alt'}, 'i') end

function Code.multipleCursorsUp()
    handleApp(fastKeyStroke, {
        [vscode] = {{'shift', 'ctrl', 'alt'}, 'up'},
        [atom] = {{'shift', 'ctrl'}, 'up'},
        [sublime] = {{'shift', 'ctrl', 'alt'}, 'up'}
    })
    -- handleApp({
    --     [atom] = _(fastKeyStroke, {'shift', 'ctrl'}, 'up'),
    --     [sublime] = _(fastKeyStroke, {'shift', 'ctrl', 'alt'}, 'up'),
    -- })
end

function Code.fold() fastKeyStroke({'alt', 'cmd'}, '[') end

function Code.unfold() fastKeyStroke({'alt', 'cmd'}, ']') end

function Code.moveLineDown()
    if appIs(notion) then
        fastKeyStroke({'shift', 'cmd'}, 'down')
    elseif inCodeEditor() then
        -- Atom, Sublime: Move line down
        fastKeyStroke({'ctrl', 'cmd'}, 'down')
    end
end

function Code.moveLineUp()
    if appIs(notion) then
        fastKeyStroke({'shift', 'cmd'}, 'up')
        fastKeyStroke({'shift', 'cmd'}, 'up')
    elseif inCodeEditor() then
        fastKeyStroke({'ctrl', 'cmd'}, 'up')
    end
end

function Code.goToDefinition() fastKeyStroke({'alt', 'cmd'}, 'down') end

function Code.toggleSemicolon()
    if inCodeEditor() then return fastKeyStroke({'alt'}, ';') end

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

function Code.toggleBoolean()
    handleApp({
        [atom] = _(fastKeyStroke, '-'),
        [sublime] = _(fastKeyStroke, {'alt', 'cmd'}, 'x')
    })
end

function Code.selectNextWord() fastKeyStroke({'cmd'}, 'd') end

function Code.multipleCursorsDown()
    fastKeyStroke({'shift', 'ctrl', 'alt'}, 'down')
end

function Code.toggleComma()
    if inCodeEditor() then return fastKeyStroke({'alt'}, ',') end

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

function Code.doubleArrow()
    insertText(' => ')
    BracketMatching.start()
end

function Code.goToMatchingPair() fastKeyStroke({'shift', 'alt', 'cmd'}, 'm') end

function Code.goToMatchingBracket() fastKeyStroke({'ctrl'}, 'm') end

function Code.comment() fastKeyStroke({'cmd'}, '/') end

function Code.selectAll() fastKeyStroke({'ctrl', 'cmd'}, 'g') end

function Code.toggleBrackets() fastKeyStroke({'shift', 'cmd'}, "'") end

function Code.previousMember() fastKeyStroke({'shift', 'alt', 'cmd'}, 'up') end

function Code.nextMember() fastKeyStroke({'shift', 'alt', 'cmd'}, 'down') end

function Code.focusBreadcrumbs() fastKeyStroke({'shift', 'cmd'}, '.') end

return Code
