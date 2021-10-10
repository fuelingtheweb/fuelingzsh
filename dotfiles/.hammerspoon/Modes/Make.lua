local MakeMode = {}
MakeMode.__index = MakeMode

MakeMode.lookup = {
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

function MakeMode.fallback(bracket)
    BracketMatching.print(bracket)
end

function MakeMode.multiBracketMatch()
    BracketMatching.startMulti()
end

function MakeMode.lineBefore()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke({'shift'}, 'o')
    end
end

function MakeMode.lineAfter()
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke('escape')
        fastKeyStroke('o')
    end
end

-- function MakeMode.startOfVideoOrPreviousVideo()
--     md.Media.startOfVideoOrPreviousVideo()
-- end

-- function MakeMode.nextVideo()
--     md.Media.nextVideo()
-- end

-- function MakeMode.focus()
--     md.Media.focus()
-- end

-- function MakeMode.fullscreen()
--     md.Media.fullscreen()
-- end

-- function MakeMode.videoBack()
--     md.Media.videoBack()
-- end

-- function MakeMode.videoForward()
--     md.Media.videoForward()
-- end

return MakeMode
