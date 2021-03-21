local ViMode = {}
ViMode.__index = ViMode

function ViMode.y()
    ViMode.moveToTopOfPage()
end

function ViMode.i()
    Pending.run({
        ViMode.moveToFirstCharacterOfLine,
        ViMode.moveAndInsertAtFirstCharacterOfLine,
    })
end

function ViMode.o()
    Pending.run({
        ViMode.moveToEndOfLine,
        ViMode.moveAndAppendAtEndOfLine,
    })
end

function ViMode.open_bracket()
    ViMode.moveToPreviousSubword()
end

function ViMode.moveToPreviousSubword()
    fastKeyStroke('escape')
    fastKeyStroke({'shift'}, 'q')
end

function ViMode.close_bracket()
    ViMode.moveToNextSubword()
end

function ViMode.moveToNextSubword()
    fastKeyStroke('escape')
    fastKeyStroke('q')
end

function ViMode.semicolon()
    ViMode.moveToPreviousWholeWord()
end

function ViMode.moveToPreviousWholeWord()
    fastKeyStroke('escape')
    fastKeyStroke({'shift'}, 'b')
end

function ViMode.quote()
    Pending.run({
        ViMode.moveToEndOfWholeWord,
        ViMode.moveToNextWholeWord,
    })
end

function ViMode.moveToEndOfWholeWord()
    fastKeyStroke('escape')
    fastKeyStroke({'shift'}, 'e')
end

function ViMode.moveToNextWholeWord()
    fastKeyStroke('escape')
    fastKeyStroke({'shift'}, 'w')
end

function ViMode.n()
    ViMode.moveToBottomOfPage()
end

function ViMode.moveToTopOfPage()
    fastKeyStroke({'cmd'}, 'up')
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
    fastKeyStroke({'cmd'}, 'down')
end

return ViMode
