local MediaMode = {}
MediaMode.__index = MediaMode

MediaMode.lookup = {
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

function MediaMode.startOfVideoOrPreviousVideo()
    -- Funimation: Start of video / previous video
    fastKeyStroke({'ctrl'}, 'left')
end

function MediaMode.spotifyMini()
    triggerAlfredWorkflow('spot_mini', 'com.vdesabou.spotify.mini.player')
end

function MediaMode.deafen()
    -- Deafen in Discord
    fastKeyStroke({'shift', 'cmd'}, 'd')
end

function MediaMode.nextVideo()
    -- Funimation: Next video
    fastKeyStroke({'ctrl'}, 'right')
end

function MediaMode.sound()
    triggerAlfredSearch('Sound')
end

function MediaMode.showVideoBar()
    -- Under System Preferences: Mouse & Trackpad, Enable Mouse Keys and set the Initial Delay option to Short
    -- original = hs.mouse.getAbsolutePosition()
    if stringContains('Prime Video', currentTitle()) then
        hs.mouse.setAbsolutePosition({x = 1900, y = 900})
        fastKeyStroke('pad6')
        hs.mouse.setAbsolutePosition({x = 1900, y = 300})
        fastKeyStroke('pad6')
    elseif stringContains('TV', currentTitle()) or stringContains('Disney', currentTitle()) then
        hs.mouse.setAbsolutePosition({x = 600, y = 900})
        fastKeyStroke('pad6')
        hs.timer.doAfter(0.8, function()
            hs.mouse.setAbsolutePosition({x = 160, y = 300})
            fastKeyStroke('pad6')
        end)
    else
        hs.mouse.setAbsolutePosition({x = 600, y = 900})
        fastKeyStroke('pad6')
        hs.mouse.setAbsolutePosition({x = 160, y = 300})
        fastKeyStroke('pad6')
    end
end

function MediaMode.focus()
    if appIs(chrome) then
        title = currentTitle()
        if stringContains('Funimation', title) then
            insertText('gf')
        elseif stringContains('Disney', title) then
            fastKeyStroke('tab')
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
            fastKeyStroke({'alt'}, 'return')
        else
            fastKeyStroke('f')
        end
    end
end

function MediaMode.updateAudioDevice()
    hs.audiodevice.findOutputByName('Built-in Output'):setDefaultOutputDevice()
end

function MediaMode.videoBack()
    if appIs(chrome) and stringContains('Funimation', currentTitle()) then
        fastKeyStroke({'shift'}, 'left')
    else
        fastKeyStroke('left')
    end
end

function MediaMode.videoForward()
    if appIs(chrome) and stringContains('Funimation', currentTitle()) then
        fastKeyStroke({'shift'}, 'right')
    else
        fastKeyStroke('right')
    end
end

return MediaMode
