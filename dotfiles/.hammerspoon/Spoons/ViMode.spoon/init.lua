local ViMode = {}
ViMode.__index = ViMode

ViMode.timer = nil

function ViMode.pending(firstCallback, secondCallback)
    if not ViMode.timer or not ViMode.timer:running() then
        ViMode.timer = hs.timer.doAfter(0.2, function()
            firstCallback()
        end)
    else
        if ViMode.timer and ViMode.timer:running() then
            ViMode.timer:stop()
        end

        secondCallback()
    end
end

function ViMode.i()
    ViMode.pending(
        ViMode.moveCursorToFirstCharacterOfLine,
        ViMode.moveCursorAndInsertAtFirstCharacterOfLine
    )
end

function ViMode.o()
    ViMode.pending(
        ViMode.moveCursorToEndOfLine,
        ViMode.moveCursorAndAppendAtEndOfLine
    )
end

function ViMode.semicolon()
    ViMode.moveCursorAndInsertAtFirstCharacterOfLine()
end

function ViMode.quote()
    ViMode.moveCursorAndAppendAtEndOfLine()
end

function ViMode.moveCursorToFirstCharacterOfLine()
    hs.eventtap.keyStroke({'cmd'}, 'left', 0)
end

function ViMode.moveCursorToEndOfLine()
    if appIs(atom) then
        hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, '4', 0)
    else
        hs.eventtap.keyStroke({'cmd'}, 'right', 0)
    end
end

function ViMode.moveCursorAndInsertAtFirstCharacterOfLine()
    if appIs(atom) then
        hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 'i', 0)
    elseif appIs(sublime) then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({'shift'}, 'i', 0)
    else
        ViMode.moveCursorToFirstCharacterOfLine()
    end
end

function ViMode.moveCursorAndAppendAtEndOfLine()
    if appIs(atom) then
        hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 'o', 0)
    elseif appIs(sublime) then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({'shift'}, 'a', 0)
    else
        ViMode.moveCursorToEndOfLine()
    end
end

return ViMode
