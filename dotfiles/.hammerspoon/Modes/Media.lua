local Media = {}
Media.__index = Media

Media.lookup = {
    tab = nil,
    q = nil,
    w = nil,
    e = nil,
    r = 'updateAudioDevice',
    t = nil,
    caps_lock = nil,
    a = 'startOfVideoOrPreviousVideo',
    s = 'spotifyMini',
    d = 'deafen',
    f = 'fullscreen',
    g = 'nextVideo',
    left_shift = nil,
    z = 'sound',
    x = nil,
    c = nil,
    v = 'focus',
    b = nil,
    spacebar = nil,

    comma = 'videoBack',
    period = 'videoForward',
}

function Media.startOfVideoOrPreviousVideo()
    -- Funimation: Start of video / previous video
    ks.ctrl('left')
end

function Media.spotifyMini()
    triggerAlfredWorkflow('spot_mini', 'com.vdesabou.spotify.mini.player')
end

function Media.deafen()
    -- Deafen in Discord
    ks.shiftCmd('d')
end

function Media.nextVideo()
    -- Funimation: Next video
    ks.ctrl('right')
end

function Media.sound()
    triggerAlfredSearch('Sound')
end

function Media.showVideoBar()
    -- Under System Preferences: Mouse & Trackpad, Enable Mouse Keys and set the Initial Delay option to Short
    -- original = hs.mouse.getAbsolutePosition()
    if stringContains('Prime Video', currentTitle()) then
        hs.mouse.setAbsolutePosition({x = 1900, y = 900})
        ks.key('pad6')
        hs.mouse.setAbsolutePosition({x = 1900, y = 300})
        ks.key('pad6')
    elseif stringContains('TV', currentTitle()) or
        stringContains('Disney', currentTitle()) then
        hs.mouse.setAbsolutePosition({x = 600, y = 900})
        ks.key('pad6')
        hs.timer.doAfter(0.8, function()
            hs.mouse.setAbsolutePosition({x = 160, y = 300})
            ks.key('pad6')
        end)
    else
        hs.mouse.setAbsolutePosition({x = 600, y = 900})
        ks.key('pad6')
        hs.mouse.setAbsolutePosition({x = 160, y = 300})
        ks.key('pad6')
    end
end

function Media.focus()
    if appIs(chrome) then
        title = currentTitle()
        if stringContains('Funimation', title) then
            ks.type('gf')
        elseif stringContains('Disney', title) then
            ks.tab()
        else
            center = hs.geometry.rectMidPoint(
                hs.mouse.getCurrentScreen():fullFrame()
            )
            hs.eventtap.leftClick(center)
            hs.eventtap.leftClick(center)
        end
    end
end

function Media.fullscreen()
    if appIs(chrome) then
        title = currentTitle()

        if stringContains('Funimation', title) then
            ks.alt('return')
        else
            ks.key('f')
        end
    end
end

function Media.updateAudioDevice()
    hs.audiodevice.findOutputByName('Built-in Output'):setDefaultOutputDevice()
end

function Media.videoBack()
    if appIs(chrome) and stringContains('Funimation', currentTitle()) then
        ks.shift('left')
    else
        ks.left()
    end
end

function Media.videoForward()
    if appIs(chrome) and stringContains('Funimation', currentTitle()) then
        ks.shift('right')
    else
        ks.right()
    end
end

return Media
