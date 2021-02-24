local ViMode = {}
ViMode.__index = ViMode

function ViMode.i()
    Pending.run({
        ViMode.moveCursorToFirstCharacterOfLine,
        ViMode.moveCursorAndInsertAtFirstCharacterOfLine,
    })
end

function ViMode.o()
    Pending.run({
        ViMode.moveCursorToEndOfLine,
        ViMode.moveCursorAndAppendAtEndOfLine,
    })
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
