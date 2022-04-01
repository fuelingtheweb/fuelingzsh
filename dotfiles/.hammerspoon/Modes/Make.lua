local Make = {}
Make.__index = Make

Make.lookup = {
    tab = nil,
    q = nil,
    w = cm.Search.window,
    e = cm.Search.viaAlfred,
    r = 'lineBefore',
    t = 'tag',
    caps_lock = Brackets.startMulti,
    a = cm.Search.amazon,
    s = 'singleQuote',
    d = 'doubleQuote',
    f = 'parenthesis',
    g = cm.Search.google,
    left_shift = nil,
    z = 'backTick',
    x = cm.Search.files,
    c = 'braces',
    v = 'lineAfter',
    b = 'brackets',
    spacebar = 'space',

    -- a = 'startOfVideoOrPreviousVideo',
    -- x = 'fullscreen',
    -- g = 'nextVideo',
    -- v = 'focus',
    -- comma = 'videoBack',
    -- period = 'videoForward',
}

function Make.fallback(bracket)
    Brackets.print(bracket)
end

function Make.lineBefore()
    if is.vimMode() then
        ks.escape().shift('o')
    end
end

function Make.lineAfter()
    if is.vimMode() then
        ks.escape().key('o')
    end
end

-- function Make.startOfVideoOrPreviousVideo()
--     md.Media.startOfVideoOrPreviousVideo()
-- end

-- function Make.nextVideo()
--     md.Media.nextVideo()
-- end

-- function Make.focus()
--     md.Media.focus()
-- end

-- function Make.fullscreen()
--     md.Media.fullscreen()
-- end

-- function Make.videoBack()
--     md.Media.videoBack()
-- end

-- function Make.videoForward()
--     md.Media.videoForward()
-- end

return Make
