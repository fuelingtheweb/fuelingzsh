local obj = {}
obj.__index = obj

hs.urlevent.bind('code-moveDown', function()
    if appIs(iterm) then
        -- iTerm: Autocomplete next word
        hs.eventtap.keyStroke({'shift', 'alt', 'cmd'}, 'J')
    elseif appIs(notion) then
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'Down')
    elseif appIs(atom) or appIs(sublime) then
        -- Atom, Sublime: Move line down
        hs.eventtap.keyStroke({'ctrl', 'cmd'}, 'Down')
    end
end)

hs.urlevent.bind('code-moveUp', function()
    if appIs(notion) then
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'Up')
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'Up')
    elseif appIs(atom) or appIs(sublime) then
        -- Atom, Sublime: Move line up
        hs.eventtap.keyStroke({'ctrl', 'cmd'}, 'Up')
    end
end)

hs.urlevent.bind('code-toggleBoolean', function()
    if appIs(sublime) then
        hs.eventtap.keyStroke({'alt', 'cmd'}, 'x')
    elseif appIs(atom) then
        hs.eventtap.keyStroke({}, '-')
    end
end)

hs.urlevent.bind('code-o', function()
    if appIs(iterm) then
        -- Git: Checkout
        typeAndEnter('gco')
    end
end)

hs.urlevent.bind('code-m', function()
    if appIs(iterm) then
        -- Git: Merge
        typeAndEnter('gm')
    else
        -- Multiple cursors down
        hs.eventtap.keyStroke({'shift', 'ctrl', 'alt'}, 'down')
    end
end)

hs.urlevent.bind('code-l', function()
    if appIs(iterm) then
        -- Git: Pull
        typeAndEnter('gpl')
    else
        -- Atom: Go to definition
        hs.eventtap.keyStroke({'alt', 'cmd'}, 'down')
    end
end)

hs.urlevent.bind('code-p', function()
    if appIs(iterm) then
        -- Git: Push
        typeAndEnter('gps')
    else
        hs.eventtap.keyStrokes(' || ')
    end
end)

hs.urlevent.bind('code-h', function()
    if appIs(iterm) then
        -- Git: Status
        typeAndEnter('gs')
    end
end)

hs.urlevent.bind('code-u', function()
    if appIs(iterm) then
        -- Git: Discard changes
        typeAndEnter('nah')
    else
        -- Atom: Add use statement
        hs.eventtap.keyStroke({'ctrl', 'alt'}, 'u')
    end
end)

hs.urlevent.bind('code-return', function()
    if appIs(iterm) then
        ProjectManager.serveCurrent()
    else
        hs.eventtap.keyStrokes('return ')
    end
end)

return obj
