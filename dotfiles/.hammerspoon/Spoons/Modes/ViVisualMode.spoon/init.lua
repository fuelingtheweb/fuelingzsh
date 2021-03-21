local ViVisualMode = {}
ViVisualMode.__index = ViVisualMode

ViVisualMode.lookup = {
    y = 'selectToTopOfPage',
    u = nil,
    i = 'selectToFirstCharacterOfLine',
    o = 'selectToEndOfLine',
    p = nil,
    open_bracket = 'selectToPreviousSubword',
    close_bracket = 'selectToNextSubword',
    semicolon = 'selectToPreviousWholeWord',
    quote = {'selectToEndOfWholeWord', 'selectToNextWholeWord'},
    return_or_enter = nil,
    n = 'selectToBottomOfPage',
    m = nil,
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

return ViVisualMode
