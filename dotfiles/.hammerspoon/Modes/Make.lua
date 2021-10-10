local Make = {}
Make.__index = Make

Make.lookup = {
    tab = nil,
    q = nil,
    w = nil,
    e = nil,
    r = 'lineBefore',
    t = 'tag',
    caps_lock = 'multiBracketMatch',
    -- a = nil,
    s = 'singleQuote',
    d = 'doubleQuote',
    f = 'parenthesis',
    -- g = nil,
    left_shift = nil,
    z = 'backTick',
    -- x = nil,
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
    BracketMatching.print(bracket)
end

function Make.multiBracketMatch()
    BracketMatching.startMulti()
end

function Make.lineBefore()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke({'shift'}, 'o')
    end
end

function Make.lineAfter()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('o')
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
