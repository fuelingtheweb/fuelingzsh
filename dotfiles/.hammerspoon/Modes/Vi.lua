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
    spacebar = nil,
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
    if is.finder() then
        ks.alt('up')
    else
        ks.cmd('up')
    end
end

function Vi.moveToFirstCharacterOfLine()
    ks.cmd('left')
end

function Vi.moveToEndOfLine()
    if is.In(atom) then
        ks.super('4')
    else
        ks.cmd('right')
    end
end

function Vi.moveAndInsertAtFirstCharacterOfLine()
    if is.In(atom) then
        ks.super('i')
    elseif is.In(sublime, vscode) then
        ks.escape().shift('i')
    else
        Vi.moveToFirstCharacterOfLine()
    end
end

function Vi.moveAndAppendAtEndOfLine()
    if is.In(atom) then
        ks.super('o')
    elseif is.In(sublime, vscode) then
        ks.escape().shift('a')
    else
        Vi.moveToEndOfLine()
    end
end

function Vi.moveToBottomOfPage()
    if is.finder() then
        ks.alt('down')
    else
        ks.cmd('down')
    end
end

function Vi.pageUp()
    ks.key('pageup')
end

function Vi.pageDown()
    ks.key('pagedown')
end

function Vi.previousWord()
    ks.alt('left')
end

function Vi.nextWord()
    ks.alt('right')
end

return Vi
