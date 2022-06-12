local mdl = {}
mdl.__index = mdl

Modal.add({
    key = 'Media',
    title = 'Media',
    allowRepeating = true,
    items = {
        h = {name = 'startOfVideoOrPreviousVideo'},
        l = {name = 'nextVideo'},
        v = {name = 'focus'},
        f = {name = 'fullscreen'},
        k = {name = 'videoBack'},
        j = {name = 'videoForward'},
    },
    callback = function(item)
        mdl[item.name]()
    end,
})

function mdl.startOfVideoOrPreviousVideo()
    -- Funimation: Start of video / previous video
    ks.ctrl('left')
end

function mdl.nextVideo()
    -- Funimation: Next video
    ks.ctrl('right')
end

function mdl.focus()
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

function mdl.fullscreen()
    if fn.window.titleContains('Funimation') then
        ks.alt('return')
    else
        ks.key('f')
    end
end

function mdl.videoBack()
    if fn.window.titleContains('Funimation') then
        ks.shift('left')
    else
        ks.left()
    end
end

function mdl.videoForward()
    if fn.window.titleContains('Funimation') then
        ks.shift('right')
    else
        ks.right()
    end
end

return mdl
