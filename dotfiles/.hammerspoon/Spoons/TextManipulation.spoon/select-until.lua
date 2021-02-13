hs.urlevent.bind('select-until-endOfWord', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'v', 0)
        hs.eventtap.keyStroke({}, 'e', 0)
    else
        hs.eventtap.keyStroke({'shift', 'alt'}, 'right', 0)
    end
end)

hs.urlevent.bind('select-until-nextWord', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'v', 0)
        hs.eventtap.keyStroke({}, 'w', 0)
    else
        hs.eventtap.keyStroke({'shift', 'alt'}, 'right', 0)
        hs.eventtap.keyStroke({'shift', 'alt'}, 'right', 0)
    end
end)

hs.urlevent.bind('select-until-endOfLine', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'right', 0)
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'right', 0)
    end
end)

hs.urlevent.bind('select-until-beginningOfLine', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'left', 0)
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'left', 0)
    end
end)

hs.urlevent.bind('select-until-previousBlock', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({'shift'}, 'v', 0)
        hs.eventtap.keyStroke({'shift', 'ctrl', 'alt', 'cmd'}, 'v', 0)
        hs.eventtap.keyStroke({'shift'}, '[', 0)
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'left', 0)
    end
end)
