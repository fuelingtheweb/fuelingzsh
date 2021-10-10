local ViVisual = {}
ViVisual.__index = ViVisual

ViVisual.lookup = {
    y = 'selectToTopOfPage',
    u = 'selectLineUp',
    i = 'selectToFirstCharacterOfLine',
    o = 'selectToEndOfLine',
    p = nil,
    open_bracket = nil,
    close_bracket = nil,
    h = 'selectLeft',
    j = 'selectDown',
    k = 'selectUp',
    l = 'selectRight',
    semicolon = 'selectToPreviousWholeWord',
    quote = 'selectToEndOfWholeWord',
    return_or_enter = 'selectToNextWholeWord',
    n = 'selectToBottomOfPage',
    m = 'selectLineDown',
    comma = 'selectPreviousWord',
    period = 'selectNextWord',
    slash = 'selectToPreviousSubword',
    right_shift = 'selectToNextSubword',
    spacebar = nil,
}

function ViVisual.selectToPreviousSubword()
    md.SelectUntil.beginSelectingBackward()
    fastKeyStroke({'shift'}, 'q')
end

function ViVisual.selectToNextSubword()
    md.SelectUntil.beginSelectingForward()
    fastKeyStroke('q')
end

function ViVisual.selectToPreviousWholeWord()
    md.SelectUntil.beginSelectingBackward()
    fastKeyStroke({'shift'}, 'b')
end

function ViVisual.selectToEndOfWholeWord()
    md.SelectUntil.beginSelectingForward()
    fastKeyStroke({'shift'}, 'e')
end

function ViVisual.selectToNextWholeWord()
    md.SelectUntil.beginSelectingForward()
    fastKeyStroke({'shift'}, 'w')
end

function ViVisual.selectToTopOfPage()
    if appIs(finder) then
        fastKeyStroke({'shift', 'alt'}, 'up')
    else
        fastKeyStroke({'shift', 'cmd'}, 'up')
    end
end

function ViVisual.selectToFirstCharacterOfLine()
    md.SelectUntil.beginningOfLine()
end

function ViVisual.selectToEndOfLine()
    fastKeyStroke({'shift', 'cmd'}, 'right')
end

function ViVisual.selectToBottomOfPage()
    if appIs(finder) then
        fastKeyStroke({'shift', 'alt'}, 'down')
    else
        fastKeyStroke({'shift', 'cmd'}, 'down')
    end
end

function ViVisual.selectLineUp()
    fastKeyStroke({'shift'}, 'v')
    fastKeyStroke('up')
end

function ViVisual.selectLineDown()
    fastKeyStroke({'shift'}, 'v')
    fastKeyStroke('down')
end

function ViVisual.selectLeft()
    if inCodeEditor() then
        fastKeyStroke({'ctrl', 'alt', 'cmd'}, 'v')
        fastKeyStroke('left')
    else
        fastKeyStroke({'shift'}, 'left')
    end
end

function ViVisual.selectDown()
    fastKeyStroke({'shift'}, 'down')
end

function ViVisual.selectUp()
    fastKeyStroke({'shift'}, 'up')
end

function ViVisual.selectRight()
    fastKeyStroke({'shift'}, 'right')
end

function ViVisual.selectPreviousWord()
    if inCodeEditor() then
        fastKeyStroke({'ctrl', 'alt', 'cmd'}, 'v')
        fastKeyStroke('left')
    end

    fastKeyStroke({'shift', 'alt'}, 'left')
end

function ViVisual.selectNextWord()
    fastKeyStroke({'shift', 'alt'}, 'right')
end

return ViVisual
