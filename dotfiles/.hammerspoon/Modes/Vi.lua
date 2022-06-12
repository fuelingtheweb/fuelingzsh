local Vi = {}
Vi.__index = Vi

Vi.lookup = {
    y = 'moveToTopOfPage',
    u = 'pageUp',
    i = 'moveToFirstCharacterOfLine',
    o = 'moveToEndOfLine',
    p = nil,
    open_bracket = 'moveAndInsertAtFirstCharacterOfLine',
    close_bracket = 'moveAndAppendAtEndOfLine',
    h = ks.left,
    j = ks.down,
    k = ks.up,
    l = ks.right,
    semicolon = 'moveToPreviousWholeWord',
    quote = 'moveToEndOfWholeWord',
    return_or_enter = 'moveToNextWholeWord',
    n = 'moveToBottomOfPage',
    m = 'pageDown',
    comma = 'previousWord',
    period = 'nextWord',
    slash = 'moveToPreviousSubword',
    right_shift = 'moveToNextSubword',
    spacebar = 'joinLines',
}

function Vi.moveToPreviousSubword()
    ks.shift('q')
end

function Vi.moveToNextSubword()
    ks.key('q')
end

function Vi.moveToPreviousWholeWord()
    ks.escape().shift('b')
end

function Vi.moveToEndOfWholeWord()
    ks.escape().shift('e')
end

function Vi.moveToNextWholeWord()
    ks.escape().shift('w')
end

function Vi.moveToTopOfPage()
    if cm.Window.scrolling then
        ks.sequence({'g', 'g'})
    elseif is.finder() then
        ks.alt('up')
    elseif is.sublimeMerge() then
        cm.Tab.previous()
        cm.Tab.next()
        hs.timer.doAfter(0.1, function()
            ks.tab()
        end)
    else
        ks.cmd('up')
    end
end

function Vi.moveToFirstCharacterOfLine()
    ks.cmd('left')
end

function Vi.moveToEndOfLine()
    ks.cmd('right')
end

function Vi.moveAndInsertAtFirstCharacterOfLine()
    if is.vscode() then
        ks.escape().shift('i')
    else
        Vi.moveToFirstCharacterOfLine()
    end
end

function Vi.moveAndAppendAtEndOfLine()
    if is.vscode() then
        ks.escape().shift('a')
    else
        Vi.moveToEndOfLine()
    end
end

function Vi.moveToBottomOfPage()
    if cm.Window.scrolling then
        ks.shift('g')
    elseif is.finder() then
        ks.alt('down')
    else
        ks.cmd('down')
    end
end

function Vi.pageUp()
    if is.vscode() then
        ks.ctrl('u')
    else
        ks.key('pageup')
    end
end

function Vi.pageDown()
    if is.vscode() then
        ks.ctrl('d')
    else
        ks.key('pagedown')
    end
end

function Vi.previousWord()
    ks.alt('left')
end

function Vi.nextWord()
    ks.alt('right')
end

function Vi.joinLines()
    if is.vscode() then
        ks.escape().shift('j').key('x')
    end
end

return Vi
