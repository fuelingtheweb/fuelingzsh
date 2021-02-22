local ViMode = {}
ViMode.__index = ViMode

function ViMode.i()
    hs.eventtap.keyStroke({'cmd'}, 'left', 0)
end

function ViMode.o()
    if appIs(atom) then
        hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, '4', 0)
    else
        hs.eventtap.keyStroke({'cmd'}, 'right', 0)
    end
end

function ViMode.semicolon()
    if appIs(atom) then
        hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 'i', 0)
    elseif appIs(sublime) then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({'shift'}, 'i', 0)
    else
        hs.eventtap.keyStroke({'cmd'}, 'left', 0)
    end
end

function ViMode.quote()
    if appIs(atom) then
        hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 'o', 0)
    elseif appIs(sublime) then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({'shift'}, 'a', 0)
    else
        hs.eventtap.keyStroke({'cmd'}, 'right', 0)
    end
end

return ViMode
