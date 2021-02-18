local ViMode = {}
ViMode.__index = ViMode

ViMode.lookup = {
    -- Key: a
    a = function()
        if inCodeEditor() then
            hs.eventtap.keyStroke({'shift'}, '4')
        else
            hs.eventtap.keyStroke({'cmd'}, 'right')
        end
    end,
}

hs.urlevent.bind('vi-mode', function(eventName, params)
    if ViMode.lookup[params.key] then
        ViMode.lookup[params.key]()
    end
end)

return ViMode
