hs.urlevent.bind('yank-toEndOfWord', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'y', 0)
        hs.eventtap.keyStroke({}, 'e', 0)
    else
        hs.eventtap.keyStroke({'shift', 'alt'}, 'right', 0)
        hs.eventtap.keyStroke({'cmd'}, 'c', 0)
        hs.eventtap.keyStroke({}, 'left', 0)
    end
end)

hs.urlevent.bind('yank-relativeFilePath', function()
    if appIs(atom) then
        hs.eventtap.keyStroke({'shift', 'ctrl', 'alt', 'cmd'}, 'y', 0)
        hs.eventtap.keyStroke({'shift', 'ctrl', 'alt', 'cmd'}, 'r', 0)
    elseif appIs(sublime) then
        hs.eventtap.keyStroke({'shift', 'ctrl', 'alt', 'cmd'}, 'y', 0)
    end
end)

hs.urlevent.bind('yank-word', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'y', 0)
        hs.eventtap.keyStroke({}, 'i', 0)
        hs.eventtap.keyStroke({}, 'w', 0)
    else
        hs.eventtap.keyStroke({'shift', 'alt'}, 'left', 0)
        hs.eventtap.keyStroke({'cmd'}, 'c', 0)
        hs.eventtap.keyStroke({}, 'right', 0)
    end
end)

hs.urlevent.bind('yank-toEndOfLine', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'y', 0)
        hs.eventtap.keyStroke({'shift'}, '4', 0)
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'right', 0)
        hs.eventtap.keyStroke({'cmd'}, 'c', 0)
        hs.eventtap.keyStroke({}, 'left', 0)
    end
end)

hs.urlevent.bind('yank-toBeginningOfLine', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'left', 0)
        hs.eventtap.keyStroke({}, 'y', 0)
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'left', 0)
        hs.eventtap.keyStroke({'cmd'}, 'c', 0)
        hs.eventtap.keyStroke({}, 'right', 0)
    end
end)

hs.urlevent.bind('yank-line', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'y', 0)
        hs.eventtap.keyStroke({}, 'y', 0)
    else
        hs.eventtap.keyStroke({'cmd'}, 'left', 0)
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'right', 0)
        hs.eventtap.keyStroke({'cmd'}, 'c', 0)
        hs.eventtap.keyStroke({}, 'right', 0)
    end
end)

hs.urlevent.bind('yank-character', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'y', 0)
        hs.eventtap.keyStroke({}, 'l', 0)
    else
        hs.eventtap.keyStroke({'shift'}, 'left', 0)
        hs.eventtap.keyStroke({'cmd'}, 'c', 0)
        hs.eventtap.keyStroke({}, 'right', 0)
    end
end)

hs.urlevent.bind('yank-all', function()
    hs.eventtap.keyStroke({'cmd'}, 'A', 0)
    hs.eventtap.keyStroke({'cmd'}, 'C', 0)
    hs.eventtap.keyStroke({}, 'Right', 0)
end)
