local obj = {}
obj.__index = obj

hs.urlevent.bind('media-showVideoBar', function()
    -- Under System Preferences: Mouse & Trackpad, Enable Mouse Keys and set the Initial Delay option to Short
    -- original = hs.mouse.getAbsolutePosition()
    if stringContains('Prime Video', currentTitle()) then
        hs.mouse.setAbsolutePosition({x = 1900, y = 900})
        hs.eventtap.keyStroke({}, 'pad6')
        hs.mouse.setAbsolutePosition({x = 1900, y = 300})
        hs.eventtap.keyStroke({}, 'pad6')
    elseif stringContains('TV', currentTitle()) then
        hs.mouse.setAbsolutePosition({x = 600, y = 900})
        hs.eventtap.keyStroke({}, 'pad6')
        hs.timer.doAfter(0.8, function()
            hs.mouse.setAbsolutePosition({x = 160, y = 300})
            hs.eventtap.keyStroke({}, 'pad6')
        end)
    else
        hs.mouse.setAbsolutePosition({x = 600, y = 900})
        hs.eventtap.keyStroke({}, 'pad6')
        hs.mouse.setAbsolutePosition({x = 160, y = 300})
        hs.eventtap.keyStroke({}, 'pad6')
    end
end)

hs.urlevent.bind('media-focus', function()
    if appIs(chrome) then
        title = currentTitle()
        if stringContains('Funimation', title) then
            hs.eventtap.keyStrokes('gf')
        elseif stringContains('Disney Plus', title) then
            hs.eventtap.keyStroke({}, 'tab')
        else
            center = hs.geometry.rectMidPoint(hs.mouse.getCurrentScreen():fullFrame())
            hs.eventtap.leftClick(center)
            hs.eventtap.leftClick(center)
        end
    end
end)

hs.urlevent.bind('media-fullscreen', function()
    if appIs(chrome) then
        title = currentTitle()
        if stringContains('Funimation', title) then
            hs.eventtap.keyStroke({'alt'}, 'return')
        else
            hs.eventtap.keyStroke({}, 'f')
        end
    end
end)

hs.urlevent.bind('media-updateAudioDevice', function()
    hs.audiodevice.findOutputByName('Built-in Output'):setDefaultOutputDevice()
end)

function videoBack()
    if appIs(chrome) and stringContains('Funimation', currentTitle()) then
        hs.eventtap.keyStroke({'shift'}, 'Left')
    else
        hs.eventtap.keyStroke({}, 'Left')
    end
end

function videoForward()
    if appIs(chrome) and stringContains('Funimation', currentTitle()) then
        hs.eventtap.keyStroke({'shift'}, 'Right')
    else
        hs.eventtap.keyStroke({}, 'Right')
    end
end

hs.urlevent.bind('media-back', videoBack, nil, videoBack)
hs.urlevent.bind('media-forward', videoForward, nil, videoForward)

return obj
