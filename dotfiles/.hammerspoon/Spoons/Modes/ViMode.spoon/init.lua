local ViMode = {}
ViMode.__index = ViMode

function ViMode.y()
    ViMode.moveToTopOfPage()
end

function ViMode.i()
    Pending.run({
        ViMode.moveToFirstCharacterOfLine,
        ViMode.moveAndInsertAtFirstCharacterOfLine,
    })
end

function ViMode.o()
    Pending.run({
        ViMode.moveToEndOfLine,
        ViMode.moveAndAppendAtEndOfLine,
    })
end

function ViMode.n()
    ViMode.moveToBottomOfPage()
end

function ViMode.moveToTopOfPage()
    hs.eventtap.keyStroke({'cmd'}, 'up', 0)
end

function ViMode.moveToFirstCharacterOfLine()
    hs.eventtap.keyStroke({'cmd'}, 'left', 0)
end

function ViMode.moveToEndOfLine()
    if appIs(atom) then
        hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, '4', 0)
    else
        hs.eventtap.keyStroke({'cmd'}, 'right', 0)
    end
end

function ViMode.moveAndInsertAtFirstCharacterOfLine()
    if appIs(atom) then
        hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 'i', 0)
    elseif appIs(sublime) then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({'shift'}, 'i', 0)
    else
        ViMode.moveToFirstCharacterOfLine()
    end
end

function ViMode.moveAndAppendAtEndOfLine()
    if appIs(atom) then
        hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 'o', 0)
    elseif appIs(sublime) then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({'shift'}, 'a', 0)
    else
        ViMode.moveToEndOfLine()
    end
end

function ViMode.moveToBottomOfPage()
    hs.eventtap.keyStroke({'cmd'}, 'down', 0)
end

return ViMode
