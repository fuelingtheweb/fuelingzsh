local MediaMode = {}
MediaMode.__index = MediaMode

function MediaMode.tab()
end

function MediaMode.q()
end

function MediaMode.w()
end

function MediaMode.e()
end

function MediaMode.r()
    MediaMode.updateAudioDevice()
end

function MediaMode.t()
end

function MediaMode.y()
end

function MediaMode.u()
end

function MediaMode.i()
end

function MediaMode.o()
end

function MediaMode.p()
end

function MediaMode.open_bracket()
end

function MediaMode.close_bracket()
end

function MediaMode.caps_lock()
end

function MediaMode.a()
    -- Funimation: Start of video / previous video
    hs.eventtap.keyStroke({'ctrl'}, 'left')
end

function MediaMode.s()
    triggerAlfredWorkflow('spot_mini', 'com.vdesabou.spotify.mini.player')
end

function MediaMode.d()
    -- Deafen in Discord
    hs.eventtap.keyStroke({'shift', 'cmd'}, 'd')
end

function MediaMode.f()
    MediaMode.fullscreen()
end

function MediaMode.g()
    -- Funimation: Next video
    hs.eventtap.keyStroke({'ctrl'}, 'right')
end

function MediaMode.h()
end

function MediaMode.j()
end

function MediaMode.k()
end

function MediaMode.l()
end

function MediaMode.semicolon()
end

function MediaMode.quote()
end

function MediaMode.return_or_enter()
end

function MediaMode.left_shift()
end

function MediaMode.z()
    triggerAlfredSearch('Sound')
end

function MediaMode.x()
end

function MediaMode.c()
end

function MediaMode.v()
    MediaMode.focus()
end

function MediaMode.b()
end

function MediaMode.n()
end

function MediaMode.m()
end

function MediaMode.comma()
    MediaMode.videoBack()
end

function MediaMode.period()
    MediaMode.videoForward()
end

function MediaMode.slash()
end

function MediaMode.right_shift()
end

function MediaMode.spacebar()
end

function MediaMode.showVideoBar()
    -- Under System Preferences: Mouse & Trackpad, Enable Mouse Keys and set the Initial Delay option to Short
    -- original = hs.mouse.getAbsolutePosition()
    if stringContains('Prime Video', currentTitle()) then
        hs.mouse.setAbsolutePosition({x = 1900, y = 900})
        hs.eventtap.keyStroke({}, 'pad6')
        hs.mouse.setAbsolutePosition({x = 1900, y = 300})
        hs.eventtap.keyStroke({}, 'pad6')
    elseif stringContains('TV', currentTitle()) or stringContains('Disney', currentTitle()) then
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
end

function MediaMode.focus()
    if appIs(chrome) then
        title = currentTitle()
        if stringContains('Funimation', title) then
            hs.eventtap.keyStrokes('gf')
        elseif stringContains('Disney', title) then
            hs.eventtap.keyStroke({}, 'tab')
        else
            center = hs.geometry.rectMidPoint(hs.mouse.getCurrentScreen():fullFrame())
            hs.eventtap.leftClick(center)
            hs.eventtap.leftClick(center)
        end
    end
end

function MediaMode.fullscreen()
    if appIs(chrome) then
        title = currentTitle()
        if stringContains('Funimation', title) then
            hs.eventtap.keyStroke({'alt'}, 'return')
        else
            hs.eventtap.keyStroke({}, 'f')
        end
    end
end

function MediaMode.updateAudioDevice()
    hs.audiodevice.findOutputByName('Built-in Output'):setDefaultOutputDevice()
end

function MediaMode.videoBack()
    if appIs(chrome) and stringContains('Funimation', currentTitle()) then
        hs.eventtap.keyStroke({'shift'}, 'Left')
    else
        hs.eventtap.keyStroke({}, 'Left')
    end
end

function MediaMode.videoForward()
    if appIs(chrome) and stringContains('Funimation', currentTitle()) then
        hs.eventtap.keyStroke({'shift'}, 'Right')
    else
        hs.eventtap.keyStroke({}, 'Right')
    end
end

return MediaMode
