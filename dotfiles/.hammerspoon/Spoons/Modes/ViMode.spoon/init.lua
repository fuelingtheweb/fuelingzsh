local ViMode = {}
ViMode.__index = ViMode

ViMode.lookup = {
    y = 'moveToTopOfPage',
    u = 'pageUp',
    i = 'moveToFirstCharacterOfLine',
    o = 'moveToEndOfLine',
    -- i = {'moveToFirstCharacterOfLine', 'moveAndInsertAtFirstCharacterOfLine'},
    -- o = {'moveToEndOfLine', 'moveAndAppendAtEndOfLine'},
    p = nil,
    open_bracket = 'moveToPreviousSubword',
    close_bracket = 'moveToNextSubword',
    h = 'left',
    j = 'down',
    k = 'up',
    l = 'right',
    semicolon = 'moveToPreviousWholeWord',
    quote = 'moveToEndOfWholeWord',
    -- quote = {'moveToEndOfWholeWord', 'moveToNextWholeWord'},
    return_or_enter = nil,
    n = 'moveToBottomOfPage',
    m = 'pageDown',
    comma = 'previousWord',
    period = 'nextWord',
    slash = nil,
    right_shift = nil,
    spacebar = nil,
}

function ViMode.moveToPreviousSubword()
    fastKeyStroke('escape')
    fastKeyStroke({'shift'}, 'q')
end

function ViMode.moveToNextSubword()
    fastKeyStroke('escape')
    fastKeyStroke('q')
end

function ViMode.moveToPreviousWholeWord()
    fastKeyStroke('escape')
    fastKeyStroke({'shift'}, 'b')
end

function ViMode.moveToEndOfWholeWord()
    fastKeyStroke('escape')
    fastKeyStroke({'shift'}, 'e')
end

function ViMode.moveToNextWholeWord()
    fastKeyStroke('escape')
    fastKeyStroke({'shift'}, 'w')
end

function ViMode.moveToTopOfPage()
    if appIs(finder) then
        fastKeyStroke({'alt'}, 'up')
    else
        fastKeyStroke({'cmd'}, 'up')
    end
end

function ViMode.moveToFirstCharacterOfLine()
    fastKeyStroke({'cmd'}, 'left')
end

function ViMode.moveToEndOfLine()
    if appIs(atom) then
        fastKeyStroke({'ctrl', 'alt', 'cmd'}, '4')
    else
        fastKeyStroke({'cmd'}, 'right')
    end
end

function ViMode.moveAndInsertAtFirstCharacterOfLine()
    if appIs(atom) then
        fastKeyStroke({'ctrl', 'alt', 'cmd'}, 'i')
    elseif appIs(sublime) then
        fastKeyStroke('escape')
        fastKeyStroke({'shift'}, 'i')
    else
        ViMode.moveToFirstCharacterOfLine()
    end
end

function ViMode.moveAndAppendAtEndOfLine()
    if appIs(atom) then
        fastKeyStroke({'ctrl', 'alt', 'cmd'}, 'o')
    elseif appIs(sublime) then
        fastKeyStroke('escape')
        fastKeyStroke({'shift'}, 'a')
    else
        ViMode.moveToEndOfLine()
    end
end

function ViMode.moveToBottomOfPage()
    if appIs(finder) then
        fastKeyStroke({'alt'}, 'down')
    else
        fastKeyStroke({'cmd'}, 'down')
    end
end

function ViMode.pageUp()
    fastKeyStroke('pageup')
end

function ViMode.left()
    fastKeyStroke('left')
end

function ViMode.down()
    fastKeyStroke('down')
end

function ViMode.up()
    fastKeyStroke('up')
end

function ViMode.right()
    fastKeyStroke('right')
end

function ViMode.pageDown()
    fastKeyStroke('pagedown')
end

function ViMode.previousWord()
    fastKeyStroke({'alt'}, 'left')
end

function ViMode.nextWord()
    fastKeyStroke({'alt'}, 'right')
end

return ViMode
