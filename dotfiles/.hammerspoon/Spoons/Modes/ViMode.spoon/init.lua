local ViMode = {}
ViMode.__index = ViMode

ViMode.lookup = {
    y = 'moveToTopOfPage',
    u = nil,
    i = {'moveToFirstCharacterOfLine', 'moveAndInsertAtFirstCharacterOfLine'},
    o = {'moveToEndOfLine', 'moveAndAppendAtEndOfLine'},
    p = nil,
    open_bracket = 'moveToPreviousSubword',
    close_bracket = 'moveToNextSubword',
    semicolon = 'moveToPreviousWholeWord',
    quote = {'moveToEndOfWholeWord', 'moveToNextWholeWord'},
    return_or_enter = nil,
    n = 'moveToBottomOfPage',
    m = nil,
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
