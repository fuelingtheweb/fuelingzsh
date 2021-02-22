local CodeMode = {}
CodeMode.__index = CodeMode

-- Key: Y
function CodeMode.y()
    hs.eventtap.keyStrokes(' && ')
end

-- Key: U
function CodeMode.u()
    if appIs(iterm) then
        -- Git: Discard changes
        typeAndEnter('nah')
    else
        -- Atom: Add use statement
        hs.eventtap.keyStroke({'ctrl', 'alt'}, 'u')
    end
end

-- Key: I
function CodeMode.i()
    -- Multiple cursors up
    hs.eventtap.keyStroke({'shift', 'ctrl', 'alt'}, 'up')
end

-- Key: O
function CodeMode.o()
    if appIs(iterm) then
        -- Git: Checkout
        typeAndEnter('gco')
    else
        hs.eventtap.keyStrokes(' != ')
    end
end

-- Key: P
function CodeMode.p()
    if appIs(iterm) then
        -- Git: Push
        typeAndEnter('gps')
    else
        hs.eventtap.keyStrokes(' || ')
    end
end

-- Key: [
function CodeMode.open_bracket()
    -- Fold
    hs.eventtap.keyStroke({'alt', 'cmd'}, '[')
end

-- Key: ]
function CodeMode.close_bracket()
    -- Unfold
    hs.eventtap.keyStroke({'alt', 'cmd'}, ']')
end

-- Key: h
function CodeMode.h()
    if appIs(iterm) then
        -- Git: Status
        typeAndEnter('gs')
    else
        hs.eventtap.keyStrokes(' == ')
    end
end

-- Key: j
function CodeMode.j()
    if appIs(iterm) then
        -- iTerm: Autocomplete next word
        hs.eventtap.keyStroke({'shift', 'alt', 'cmd'}, 'J')
    elseif appIs(notion) then
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'Down')
    elseif appIs(atom) or appIs(sublime) then
        -- Atom, Sublime: Move line down
        hs.eventtap.keyStroke({'ctrl', 'cmd'}, 'Down')
    end
end

-- Key: k
function CodeMode.k()
    if appIs(notion) then
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'Up')
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'Up')
    elseif appIs(atom) or appIs(sublime) then
        -- Atom, Sublime: Move line up
        hs.eventtap.keyStroke({'ctrl', 'cmd'}, 'Up')
    end
end

-- Key: l
function CodeMode.l()
    if appIs(iterm) then
        -- Git: Pull
        typeAndEnter('gpl')
    else
        -- Atom: Go to definition
        hs.eventtap.keyStroke({'alt', 'cmd'}, 'down')
    end
end

-- Key: ;
function CodeMode.semicolon()
    -- Atom: Toggle semicolon at end of line
    hs.eventtap.keyStroke({'alt'}, ';')
end

-- Key: '
function CodeMode.quote()
    hs.eventtap.keyStrokes(' = ')
end

-- Key: return_or_enter
function CodeMode.return_or_enter()
    if appIs(iterm) then
        ProjectManager.serveCurrent()
    else
        hs.eventtap.keyStrokes('return')
    end
end

-- Key: b
function CodeMode.b()
    if appIs(sublime) then
        hs.eventtap.keyStroke({'alt', 'cmd'}, 'x')
    elseif appIs(atom) then
        -- Toggle Boolean
        hs.eventtap.keyStroke({}, '-')
    end
end

-- Key: n
function CodeMode.n()
    -- Select next word
    hs.eventtap.keyStroke({'cmd'}, 'd')
end

-- Key: m
function CodeMode.m()
    if appIs(iterm) then
        -- Git: Merge
        typeAndEnter('gm')
    else
        -- Multiple cursors down
        hs.eventtap.keyStroke({'shift', 'ctrl', 'alt'}, 'down')
    end
end

-- Key: ,
function CodeMode.comma()
    -- Atom: Toggle comma at end of line
    hs.eventtap.keyStroke({'alt'}, ',')
end

-- Key: .
function CodeMode.period()
    hs.eventtap.keyStrokes(' => ')
end

-- Key: /
function CodeMode.slash()
    -- Atom: Go to matching bracket
    hs.eventtap.keyStroke({'ctrl'}, 'm')
end

-- Key: spacebar
function CodeMode.spacebar()
    -- Comment
    hs.eventtap.keyStroke({'cmd'}, '/')
end

return CodeMode
