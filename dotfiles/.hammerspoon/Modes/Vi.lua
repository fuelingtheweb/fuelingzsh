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
    h = 'left',
    j = 'down',
    k = 'up',
    l = 'right',
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
    fastKeyStroke('escape')
    fastKeyStroke({'shift'}, 'q')
end

function Vi.moveToNextSubword()
    fastKeyStroke('escape')
    fastKeyStroke('q')
end

function Vi.moveToPreviousWholeWord()
    fastKeyStroke('escape')
    fastKeyStroke({'shift'}, 'b')
end

function Vi.moveToEndOfWholeWord()
    fastKeyStroke('escape')
    fastKeyStroke({'shift'}, 'e')
end

function Vi.moveToNextWholeWord()
    fastKeyStroke('escape')
    fastKeyStroke({'shift'}, 'w')
end

function Vi.moveToTopOfPage()
    if appIs(finder) then
        fastKeyStroke({'alt'}, 'up')
    else
        fastKeyStroke({'cmd'}, 'up')
    end
end

function Vi.moveToFirstCharacterOfLine()
    fastKeyStroke({'cmd'}, 'left')
end

function Vi.moveToEndOfLine()
    if appIs(atom) then
        fastKeyStroke({'ctrl', 'alt', 'cmd'}, '4')
    else
        fastKeyStroke({'cmd'}, 'right')
    end
end

function Vi.moveAndInsertAtFirstCharacterOfLine()
    if appIs(atom) then
        fastKeyStroke({'ctrl', 'alt', 'cmd'}, 'i')
    elseif appIs(sublime) then
        fastKeyStroke('escape')
        fastKeyStroke({'shift'}, 'i')
    else
        Vi.moveToFirstCharacterOfLine()
    end
end

function Vi.moveAndAppendAtEndOfLine()
    if appIs(atom) then
        fastKeyStroke({'ctrl', 'alt', 'cmd'}, 'o')
    elseif appIs(sublime) then
        fastKeyStroke('escape')
        fastKeyStroke({'shift'}, 'a')
    else
        Vi.moveToEndOfLine()
    end
end

function Vi.moveToBottomOfPage()
    if appIs(finder) then
        fastKeyStroke({'alt'}, 'down')
    else
        fastKeyStroke({'cmd'}, 'down')
    end
end

function Vi.pageUp()
    fastKeyStroke('pageup')
end

function Vi.left()
    fastKeyStroke('left')
end

function Vi.down()
    fastKeyStroke('down')
end

function Vi.up()
    fastKeyStroke('up')
end

function Vi.right()
    fastKeyStroke('right')
end

function Vi.pageDown()
    fastKeyStroke('pagedown')
end

function Vi.previousWord()
    fastKeyStroke({'alt'}, 'left')
end

function Vi.nextWord()
    fastKeyStroke({'alt'}, 'right')
end

return Vi
