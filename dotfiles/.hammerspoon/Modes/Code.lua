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
    spacebar = 'comment',
}

function Code.addUseStatement()
    ks.ctrlAlt('i')
end

function Code.multipleCursorsUp()
    handleApp(ks.fire, {
        [vscode] = {{'shift', 'ctrl', 'alt'}, 'up'},
        [atom] = {{'shift', 'ctrl'}, 'up'},
        [sublime] = {{'shift', 'ctrl', 'alt'}, 'up'},
    })
    -- handleApp({
    --     [atom] = _(ks.fire, {'shift', 'ctrl'}, 'up'),
    --     [sublime] = _(ks.fire, {'shift', 'ctrl', 'alt'}, 'up'),
    -- })
end

function Code.fold()
    ks.altCmd('[')
end

function Code.unfold()
    ks.altCmd(']')
end

function Code.moveLineDown()
    if is.In(notion) then
        ks.shiftCmd('down')
    elseif is.codeEditor() then
        -- Atom, Sublime: Move line down
        ks.ctrlCmd('down')
    end
end

function Code.moveLineUp()
    if is.In(notion) then
        ks.shiftCmd('up').shiftCmd('up')
    elseif is.codeEditor() then
        ks.ctrlCmd('up')
    end
end

function Code.goToDefinition()
    ks.altCmd('down')
end

function Code.toggleSemicolon()
    if is.codeEditor() then
        return ks.alt(';')
    end

    md.Vi.moveToEndOfLine()
    ks.shift('left')
    text = getSelectedText()

    if getSelectedText() == ';' then
        ks.delete()
    else
        ks.right().type(';')
    end
end

function Code.toggleBoolean()
    handleApp({
        [atom] = _(ks.fire, '-'),
        [sublime] = _(ks.fire, {'alt', 'cmd'}, 'x'),
    })
end

function Code.selectNextWord()
    ks.cmd('d')
end

function Code.multipleCursorsDown()
    if is.codeEditor() then
        ks.shiftCtrlAlt('down')
    elseif is.github() and titleContains('Pull Request #') then
        ks.cmd('g')
        md.ViVisual.selectToTopOfPage()
        md.ViVisual.selectLineDown()
        ks.delete().delete()
    end
end

function Code.toggleComma()
    if is.codeEditor() then
        return ks.alt(',')
    end

    md.Vi.moveToEndOfLine()
    ks.shift('left')
    text = getSelectedText()

    if getSelectedText() == ',' then
        ks.delete()
    else
        ks.right().type(',')
    end
end

function Code.doubleArrow()
    ks.type(' => ')
    Brackets.startIfPhp()
end

function Code.goToMatchingPair()
    ks.shiftAltCmd('m')
end

function Code.goToMatchingBracket()
    ks.ctrl('m')
end

function Code.comment()
    ks.cmd('/')
end

function Code.selectAll()
    ks.ctrlCmd('g')
end

function Code.toggleBrackets()
    ks.shiftCmd("'")
end

function Code.previousMember()
    ks.shiftAltCmd('up')
end

function Code.nextMember()
    ks.shiftAltCmd('down')
end

function Code.focusBreadcrumbs()
    ks.shiftCmd('.')
end

return Code
