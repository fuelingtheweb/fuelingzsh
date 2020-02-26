local obj = {}
obj.__index = obj

hs.urlevent.bind('code-moveDown', function()
    if appIs(iterm) then
        -- iTerm: Autocomplete next word
        hs.eventtap.keyStroke({'shift', 'alt', 'cmd'}, 'J')
    elseif appIs(notion) then
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'Down')
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

return obj
