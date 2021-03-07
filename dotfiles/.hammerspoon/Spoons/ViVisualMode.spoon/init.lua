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
    hs.eventtap.keyStroke({'shift', 'cmd'}, 'up', 0)
end

function ViVisualMode.selectToFirstCharacterOfLine()
    hs.eventtap.keyStroke({'shift', 'cmd'}, 'left', 0)
end

function ViVisualMode.selectToEndOfLine()
    hs.eventtap.keyStroke({'shift', 'cmd'}, 'right', 0)
end

function ViVisualMode.selectToBottomOfPage()
    hs.eventtap.keyStroke({'shift', 'cmd'}, 'down', 0)
end

return ViVisualMode
