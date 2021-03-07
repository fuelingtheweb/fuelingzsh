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

function ViVisualMode.n()
    ViVisualMode.selectToBottomOfPage()
end

function ViVisualMode.selectToTopOfPage()
    fastKeyStroke({'shift', 'cmd'}, 'up')
end

function ViVisualMode.selectToFirstCharacterOfLine()
    fastKeyStroke({'shift', 'cmd'}, 'left')
end

function ViVisualMode.selectToEndOfLine()
    fastKeyStroke({'shift', 'cmd'}, 'right')
end

function ViVisualMode.selectToBottomOfPage()
    fastKeyStroke({'shift', 'cmd'}, 'down')
end

return ViVisualMode
