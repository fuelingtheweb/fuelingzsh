local ViVisualMode = {}
ViVisualMode.__index = ViVisualMode

function ViVisualMode.y()
    ViVisualMode.selectToTopOfPage()
end

function ViVisualMode.i()
    ViVisualMode.selectToFirstCharacterOfLine()
end

function ViVisualMode.o()
    ViVisualMode.selectToEndOfLine()
end

function ViVisualMode.open_bracket()
    ViVisualMode.selectToPreviousSubword()
end

function ViVisualMode.selectToPreviousSubword()
    spoon.SelectUntilMode.beginSelectingBackward()
    fastKeyStroke({'shift'}, 'q')
end

function ViVisualMode.close_bracket()
    ViVisualMode.selectToNextSubword()
end

function ViVisualMode.selectToNextSubword()
    spoon.SelectUntilMode.beginSelectingForward()
    fastKeyStroke('q')
end

function ViVisualMode.semicolon()
    ViVisualMode.selectToPreviousWholeWord()
end

function ViVisualMode.selectToPreviousWholeWord()
    spoon.SelectUntilMode.beginSelectingBackward()
    fastKeyStroke({'shift'}, 'b')
end

function ViVisualMode.quote()
    Pending.run({
        ViVisualMode.selectToEndOfWholeWord,
        ViVisualMode.selectToNextWholeWord,
    })
end

function ViVisualMode.selectToEndOfWholeWord()
    spoon.SelectUntilMode.beginSelectingForward()
    fastKeyStroke({'shift'}, 'e')
end

function ViVisualMode.selectToNextWholeWord()
    spoon.SelectUntilMode.beginSelectingForward()
    fastKeyStroke({'shift'}, 'w')
end

function ViVisualMode.n()
    ViVisualMode.selectToBottomOfPage()
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
