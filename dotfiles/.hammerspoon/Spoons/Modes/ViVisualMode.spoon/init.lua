local ViVisualMode = {}
ViVisualMode.__index = ViVisualMode

ViVisualMode.lookup = {
    y = 'selectToTopOfPage',
    u = 'selectLineUp',
    i = 'selectToFirstCharacterOfLine',
    o = 'selectToEndOfLine',
    p = nil,
    open_bracket = 'selectToPreviousSubword',
    close_bracket = 'selectToNextSubword',
    h = 'selectLeft',
    j = 'selectDown',
    k = 'selectUp',
    l = 'selectRight',
    semicolon = 'selectToPreviousWholeWord',
    quote = {'selectToEndOfWholeWord', 'selectToNextWholeWord'},
    return_or_enter = nil,
    n = 'selectToBottomOfPage',
    m = 'selectLineDown',
    comma = 'selectPreviousWord',
    period = 'selectNextWord',
    slash = nil,
    right_shift = nil,
    spacebar = nil,
}

function ViVisualMode.selectToPreviousSubword()
    spoon.SelectUntilMode.beginSelectingBackward()
    fastKeyStroke({'shift'}, 'q')
end

function ViVisualMode.selectToNextSubword()
    spoon.SelectUntilMode.beginSelectingForward()
    fastKeyStroke('q')
end

function ViVisualMode.selectToPreviousWholeWord()
    spoon.SelectUntilMode.beginSelectingBackward()
    fastKeyStroke({'shift'}, 'b')
end

function ViVisualMode.selectToEndOfWholeWord()
    spoon.SelectUntilMode.beginSelectingForward()
    fastKeyStroke({'shift'}, 'e')
end

function ViVisualMode.selectToNextWholeWord()
    spoon.SelectUntilMode.beginSelectingForward()
    fastKeyStroke({'shift'}, 'w')
end

function ViVisualMode.selectToTopOfPage()
    fastKeyStroke({'shift', 'cmd'}, 'up')
end

function ViVisualMode.selectToFirstCharacterOfLine()
    spoon.SelectUntilMode.beginningOfLine()
end

function ViVisualMode.selectToEndOfLine()
    fastKeyStroke({'shift', 'cmd'}, 'right')
end

function ViVisualMode.selectToBottomOfPage()
    fastKeyStroke({'shift', 'cmd'}, 'down')
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
    fastKeyStroke({'shift'}, 'left')
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
    fastKeyStroke({'shift', 'alt'}, 'left')
end

function ViVisualMode.selectNextWord()
    fastKeyStroke({'shift', 'alt'}, 'right')
end

return ViVisualMode
