local ViMode = {}
ViMode.__index = ViMode

ViMode.lookup = {
    -- Key: i
    i = function()
        hs.eventtap.keyStroke({'cmd'}, 'left', 0)
    end,

    -- Key: o
    o = function()
        if appIs(atom) then
            hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, '4', 0)
        else
            hs.eventtap.keyStroke({'cmd'}, 'right', 0)
        end
    end,

    -- Key: ;
    semicolon = function()
        if appIs(atom) then
            hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 'i', 0)
        elseif appIs(sublime) then
            hs.eventtap.keyStroke({}, 'escape', 0)
            hs.eventtap.keyStroke({'shift'}, 'i', 0)
        else
            hs.eventtap.keyStroke({'cmd'}, 'left', 0)
        end
    end,

    -- Key: '
    quote = function()
        if appIs(atom) then
            hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 'o', 0)
        elseif appIs(sublime) then
            hs.eventtap.keyStroke({}, 'escape', 0)
            hs.eventtap.keyStroke({'shift'}, 'a', 0)
        else
            hs.eventtap.keyStroke({'cmd'}, 'right', 0)
        end
    end,
}

return ViMode
