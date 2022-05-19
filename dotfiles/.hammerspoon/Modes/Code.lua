local Code = {}
Code.__index = Code

Code.lookup = {
    y = 'multipleCursorsUp',
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
    if is.vscode() then
        ks.shiftCtrlAlt('up')
    end
end

function Code.fold()
    if is.sublimeMerge() then
        ks.shift('delete')
    else
        ks.altCmd('[')
    end
end

function Code.unfold()
    ks.altCmd(']')
end

function Code.moveLineDown()
    if is.codeEditor() then
        ks.ctrlCmd('down')
    elseif is.iterm() then
        ks.super('j')
    elseif is.sublimeMerge() then
        ks.tab()
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
    if is.codeEditor() then
        ks.ctrlCmd('up')
    elseif is.sublimeMerge() then
        ks.shift('tab')
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
    ks.cmd('d')
end

function Code.multipleCursorsDown()
    if is.codeEditor() then
        ks.shiftCtrlAlt('down')
    elseif is.sublimeMerge() then
        ks.delete()
    elseif is.github() and fn.window.titleContains('Pull Request #') then
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

    if str.selected() == ',' then
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
    if is.iterm() then
        ks.typeAndEnter('ci')
    elseif is.sublimeMerge() then
        ks.shiftEnter()
        hs.timer.doAfter(0.2, function()
            hs.eventtap.leftClick({x = 133, y = 203})
            hs.mouse.setAbsolutePosition({x = 5, y = 203})
        end)
    else
        ks.ctrlCmd('g')
    end
end

function Code.toggleBrackets()
    if is.sublimeMerge() then
        ks.enter()
        hs.timer.doAfter(0.2, function()
            hs.eventtap.leftClick({x = 133, y = 203})
            hs.mouse.setAbsolutePosition({x = 5, y = 203})
        end)
    else
        ks.shiftCmd("'")
    end
end

function Code.previousMember()
    if is.sublimeMerge() then
        cm.Tab.previous()
        hs.timer.doAfter(0.1, function()
            ks.tab()
        end)
    else
        ks.shiftAltCmd('up')
    end
end

function Code.nextMember()
    if is.sublimeMerge() then
        cm.Tab.next()
        hs.timer.doAfter(0.1, function()
            ks.tab()
        end)
    else
        ks.shiftAltCmd('down')
    end
end

function Code.focusBreadcrumbs()
    ks.shiftCmd('.')
end

function Code.compareActiveFileWith()
    ks.super('c').super('w')
end

return Code
