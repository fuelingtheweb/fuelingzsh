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

hs.urlevent.bind('select-until-single-quote', function()
    if not TextManipulation.canManipulateWithVim() then
        return
    end

    if appIs(atom) then
        hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 'v', 0)
        hs.eventtap.keyStroke({}, 'l', 0)
    elseif appIs(sublime) then
        hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 'v', 0)
    end

    hs.eventtap.keyStroke({}, 't', 0)
    hs.eventtap.keyStroke({}, "'", 0)
end)

hs.urlevent.bind('select-until-previous-single-quote', function()
    if not TextManipulation.canManipulateWithVim() then
        return
    end

    if inCodeEditor() then
        hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 'v', 0)
        hs.eventtap.keyStroke({}, 'h', 0)
    end

    hs.eventtap.keyStroke({'shift'}, 't', 0)
    hs.eventtap.keyStroke({}, "'", 0)
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
