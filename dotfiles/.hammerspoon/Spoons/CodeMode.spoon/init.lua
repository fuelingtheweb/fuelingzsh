local CodeMode = {}
CodeMode.__index = CodeMode

function CodeMode.y()
    hs.eventtap.keyStrokes(' && ')
end

function CodeMode.u()
    if appIs(iterm) then
        -- Git: Discard changes
        typeAndEnter('nah')
    else
        -- Atom: Add use statement
        hs.eventtap.keyStroke({'ctrl', 'alt'}, 'u')
    end
end

function CodeMode.i()
    -- Multiple cursors up
    hs.eventtap.keyStroke({'shift', 'ctrl', 'alt'}, 'up')
end

function CodeMode.o()
    if appIs(iterm) then
        -- Git: Checkout
        typeAndEnter('gco')
    else
        hs.eventtap.keyStrokes(' != ')
    end
end

function CodeMode.p()
    if appIs(iterm) then
        -- Git: Push
        typeAndEnter('gps')
    else
        hs.eventtap.keyStrokes(' || ')
    end
end

function CodeMode.open_bracket()
    -- Fold
    hs.eventtap.keyStroke({'alt', 'cmd'}, '[')
end

function CodeMode.close_bracket()
    -- Unfold
    hs.eventtap.keyStroke({'alt', 'cmd'}, ']')
end

function CodeMode.h()
    if appIs(iterm) then
        -- Git: Status
        typeAndEnter('gs')
    else
        hs.eventtap.keyStrokes(' == ')
    end
end

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

function CodeMode.k()
    if appIs(notion) then
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'Up')
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'Up')
    elseif appIs(atom) or appIs(sublime) then
        -- Atom, Sublime: Move line up
        hs.eventtap.keyStroke({'ctrl', 'cmd'}, 'Up')
    end
end

function CodeMode.l()
    if appIs(iterm) then
        -- Git: Pull
        typeAndEnter('gpl')
    else
        -- Atom: Go to definition
        hs.eventtap.keyStroke({'alt', 'cmd'}, 'down')
    end
end

function CodeMode.semicolon()
    -- Atom: Toggle semicolon at end of line
    hs.eventtap.keyStroke({'alt'}, ';')
end

function CodeMode.quote()
    hs.eventtap.keyStrokes(' = ')
end

function CodeMode.return_or_enter()
    if appIs(iterm) then
        ProjectManager.serveCurrent()
    else
        hs.eventtap.keyStrokes('return')
    end
end

function CodeMode.b()
    if appIs(sublime) then
        hs.eventtap.keyStroke({'alt', 'cmd'}, 'x')
    elseif appIs(atom) then
        -- Toggle Boolean
        hs.eventtap.keyStroke({}, '-')
    end
end

function CodeMode.n()
    -- Select next word
    hs.eventtap.keyStroke({'cmd'}, 'd')
end

function CodeMode.m()
    if appIs(iterm) then
        -- Git: Merge
        typeAndEnter('gm')
    else
        -- Multiple cursors down
        hs.eventtap.keyStroke({'shift', 'ctrl', 'alt'}, 'down')
    end
end

function CodeMode.comma()
    -- Atom: Toggle comma at end of line
    hs.eventtap.keyStroke({'alt'}, ',')
end

function CodeMode.period()
    hs.eventtap.keyStrokes(' => ')
end

function CodeMode.slash()
    -- Atom: Go to matching bracket
    hs.eventtap.keyStroke({'ctrl'}, 'm')
end

function CodeMode.spacebar()
    -- Comment
    hs.eventtap.keyStroke({'cmd'}, '/')
end

return CodeMode
