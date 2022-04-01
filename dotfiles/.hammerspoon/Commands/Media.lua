local Media = {}
Media.__index = Media

function Media.toggleAudio()
    ks.shiftCmd('a')
end

function Media.toggleScreenShare()
    ks.shiftCmd('s')
end

function Media.toggleVideo()
    ks.shiftCmd('v')
end

function Media.toggleAudioAndVideo()
    Media.toggleAudio()
    Media.toggleVideo()
end

return Media
