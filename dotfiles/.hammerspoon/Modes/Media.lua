local Media = {}
Media.__index = Media

Media.lookup = {
    tab = nil,
    q = nil,
    w = nil,
    e = nil,
    r = 'updateAudioDevice',
    t = nil,
    caps_lock = fn.misc.DismissNotifications,
    a = 'startOfVideoOrPreviousVideo',
    s = 'spotifyMini',
    d = 'deafen',
    f = 'fullscreen',
    g = 'nextVideo',
    left_shift = 'dismissAppNotifications',
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
    fn.Alfred.run('spot_mini', 'com.vdesabou.spotify.mini.player')
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
    fn.Alfred.search('Sound')
end

function Media.showVideoBar()
    -- Under System Preferences: Mouse & Trackpad, Enable Mouse Keys and set the Initial Delay option to Short
    -- original = hs.mouse.getAbsolutePosition()
    if fn.window.titleContains('Prime Video') then
        hs.mouse.setAbsolutePosition({x = 1900, y = 900})
        ks.key('pad6')
        hs.mouse.setAbsolutePosition({x = 1900, y = 300})
        ks.key('pad6')
    elseif fn.window.titleContains('TV') or fn.window.titleContains('Disney') then
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
    if is.chrome() then
        if fn.window.titleContains('Funimation') then
            ks.type('gf')
        elseif fn.window.titleContains('Disney') then
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
    if is.chrome() then
        if fn.window.titleContains('Funimation') then
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
    if is.chrome() and fn.window.titleContains('Funimation') then
        ks.shift('left')
    else
        ks.left()
    end
end

function Media.videoForward()
    if is.chrome() and fn.window.titleContains('Funimation') then
        ks.shift('right')
    else
        ks.right()
    end
end

function Media.dismissAppNotifications()
    ks.alt('w')
end

return Media
