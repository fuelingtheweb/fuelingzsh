local Code = {}
Code.__index = Code

Code.lookup = {
    y = 'codeInfo',
    u = 'addUseStatement',
    i = 'focusBreadcrumbs',
    o = 'goToDefinition',
    p = 'compareActiveFileWith',
    open_bracket = 'fold',
    close_bracket = 'unfold',
    h = 'previousMember',
    j = 'moveLineDown',
    k = 'moveLineUp',
    l = 'nextMember',
    semicolon = 'toggleSemicolon',
    quote = 'triggerCopilot',
    -- quote = 'toggleBrackets',
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
    if is.vscode() then
        ks.shiftCtrlAlt('up')
    end
end

function Code.fold()
    ks.altCmd('[')
end

function Code.unfold()
    ks.altCmd(']')
end

function Code.moveLineDown()
    if is.codeEditor() or is.obsidian() then
        ks.ctrlCmd('down')
    else
        md.SelectInside.line()
        ks.slow().copy().delete().delete()
        ks.type('a').shift('left').shift('left')

        local text = str.selected()

        ks.right().delete().down()

        if text ~= 'a' then
            ks.down()
        end

        md.Vi.moveToFirstCharacterOfLine()
        ks.enter()
        md.Destroy.toBeginningOfLine()
        ks.up().paste()
    end
end

function Code.moveLineUp()
    if is.codeEditor() or is.obsidian() then
        ks.ctrlCmd('up')
    else
        md.SelectInside.line()
        ks.slow().copy().delete().delete()
        md.Vi.moveToFirstCharacterOfLine()
        ks.enter()
        md.Destroy.toBeginningOfLine()
        ks.up().paste()
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

    if str.selected() == ';' then
        ks.delete()
    else
        ks.right().type(';')
    end
end

function Code.selectNextWord()
    if is.github() and fn.window.titleContains('Pull Request #') then
        ks.cmd('g')
        md.Command.edit()
    else
        ks.cmd('d')
    end
end

function Code.multipleCursorsDown()
    if is.codeEditor() then
        ks.shiftCtrlAlt('down')
    end
end

function Code.toggleComma()
    if is.codeEditor() then
        return ks.alt(',')
    end

    md.Vi.moveToEndOfLine()
    ks.shift('left')

    if str.selected() == ',' then
        ks.delete()
    else
        ks.right().type(',')
    end
end

function Code.doubleArrow()
    ks.type(' => ')
    -- Brackets.startIfPhp()
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
    if is.terminal() then
        ks.typeAndEnter('ci')
    else
        ks.ctrlCmd('g')
    end
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

function Code.compareActiveFileWith()
    ks.super('c').super('w')
end

function Code.codeInfo()
    ks.cmd('k').cmd('i')
end

function Code.triggerCopilot()
    ks.alt('\\')
end

return Code
