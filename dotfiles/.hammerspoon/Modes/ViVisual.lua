local ViVisualMode = {}
ViVisualMode.__index = ViVisualMode

ViVisualMode.lookup = {
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

function ViVisualMode.selectToPreviousSubword()
    md.SelectUntil.beginSelectingBackward()
    fastKeyStroke({'shift'}, 'q')
end

function ViVisualMode.selectToNextSubword()
    md.SelectUntil.beginSelectingForward()
    fastKeyStroke('q')
end

function ViVisualMode.selectToPreviousWholeWord()
    md.SelectUntil.beginSelectingBackward()
    fastKeyStroke({'shift'}, 'b')
end

function ViVisualMode.selectToEndOfWholeWord()
    md.SelectUntil.beginSelectingForward()
    fastKeyStroke({'shift'}, 'e')
end

function ViVisualMode.selectToNextWholeWord()
    md.SelectUntil.beginSelectingForward()
    fastKeyStroke({'shift'}, 'w')
end

function ViVisualMode.selectToTopOfPage()
    if appIs(finder) then
        fastKeyStroke({'shift', 'alt'}, 'up')
    else
        fastKeyStroke({'shift', 'cmd'}, 'up')
    end
end

function ViVisualMode.selectToFirstCharacterOfLine()
    md.SelectUntil.beginningOfLine()
end

function ViVisualMode.selectToEndOfLine()
    fastKeyStroke({'shift', 'cmd'}, 'right')
end

function ViVisualMode.selectToBottomOfPage()
    if appIs(finder) then
        fastKeyStroke({'shift', 'alt'}, 'down')
    else
        fastKeyStroke({'shift', 'cmd'}, 'down')
    end
end

function ViVisualMode.selectLineUp()
    fastKeyStroke({'shift'}, 'v')
    fastKeyStroke('up')
end

function ViVisualMode.selectLineDown()
    fastKeyStroke({'shift'}, 'v')
    fastKeyStroke('down')
end

function ViVisualMode.selectLeft()
    if inCodeEditor() then
        fastKeyStroke({'ctrl', 'alt', 'cmd'}, 'v')
        fastKeyStroke('left')
    else
        fastKeyStroke({'shift'}, 'left')
    end
end

function ViVisualMode.selectDown()
    fastKeyStroke({'shift'}, 'down')
end

function ViVisualMode.selectUp()
    fastKeyStroke({'shift'}, 'up')
end

function ViVisualMode.selectRight()
    fastKeyStroke({'shift'}, 'right')
end

function ViVisualMode.selectPreviousWord()
    if inCodeEditor() then
        fastKeyStroke({'ctrl', 'alt', 'cmd'}, 'v')
        fastKeyStroke('left')
    end

    fastKeyStroke({'shift', 'alt'}, 'left')
end

function ViVisualMode.selectNextWord()
    fastKeyStroke({'shift', 'alt'}, 'right')
end

return ViVisualMode
