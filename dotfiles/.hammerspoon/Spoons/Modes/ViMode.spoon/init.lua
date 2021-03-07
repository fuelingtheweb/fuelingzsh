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
    fastKeyStroke({'cmd'}, 'up')
end

function ViMode.moveToFirstCharacterOfLine()
    fastKeyStroke({'cmd'}, 'left')
end

function ViMode.moveToEndOfLine()
    if appIs(atom) then
        fastKeyStroke({'ctrl', 'alt', 'cmd'}, '4')
    else
        fastKeyStroke({'cmd'}, 'right')
    end
end

function ViMode.moveAndInsertAtFirstCharacterOfLine()
    if appIs(atom) then
        fastKeyStroke({'ctrl', 'alt', 'cmd'}, 'i')
    elseif appIs(sublime) then
        fastKeyStroke('escape')
        fastKeyStroke({'shift'}, 'i')
    else
        ViMode.moveToFirstCharacterOfLine()
    end
end

function ViMode.moveAndAppendAtEndOfLine()
    if appIs(atom) then
        fastKeyStroke({'ctrl', 'alt', 'cmd'}, 'o')
    elseif appIs(sublime) then
        fastKeyStroke('escape')
        fastKeyStroke({'shift'}, 'a')
    else
        ViMode.moveToEndOfLine()
    end
end

function ViMode.moveToBottomOfPage()
    fastKeyStroke({'cmd'}, 'down')
end

return ViMode
