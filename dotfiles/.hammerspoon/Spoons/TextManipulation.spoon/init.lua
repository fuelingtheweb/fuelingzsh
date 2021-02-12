local obj = {}
obj.__index = obj

hs.urlevent.bind('dialogCase', function(eventName, params)
    triggerAlfredWorkflow('case-dialog', 'com.fuelingtheweb.commands', params.to)
end)

hs.urlevent.bind('changeCaseAndConvert', function(eventName, params)
    result = trim(hs.execute('/Users/nathan/.nvm/versions/node/v12.4.0/bin/node /Users/nathan/.fuelingzsh/bin/change-case/bin/index.js "' .. params.to .. '" "' .. params.text .. '"'))
    hs.eventtap.keyStrokes(result, 0)
end)

hs.urlevent.bind('changeCase', function(eventName, params)
    if appIncludes({atom, sublime}) then
        hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 'c', 0)
        hs.eventtap.keyStroke({'ctrl', 'alt'}, params.key, 0)
    else
        text = getSelectedText()

        if not text then
            hs.eventtap.keyStroke({'shift', 'alt'}, 'left', 0)
            text = getSelectedText()
        end

        result = trim(hs.execute('/Users/nathan/.nvm/versions/node/v12.4.0/bin/node /Users/nathan/.fuelingzsh/bin/change-case/bin/index.js "' .. params.to .. '" "' .. text .. '"'))
        hs.eventtap.keyStrokes(result, 0)
    end
end)

hs.urlevent.bind('yank-toEndOfWord', function()
    if appIncludes({sublime, atom}) then
        hs.eventtap.keyStroke({}, 'escape')
        hs.eventtap.keyStrokes('ye')
    else
        hs.eventtap.keyStroke({'shift', 'alt'}, 'right')
        hs.eventtap.keyStroke({'cmd'}, 'c')
        hs.eventtap.keyStroke({}, 'left')
    end
end)

hs.urlevent.bind('yank-relativeFilePath', function()
    if appIs(atom) then
        hs.eventtap.keyStroke({'shift', 'ctrl', 'alt', 'cmd'}, 'y')
        hs.eventtap.keyStroke({'shift', 'ctrl', 'alt', 'cmd'}, 'r')
    elseif appIs(sublime) then
        hs.eventtap.keyStroke({'shift', 'ctrl', 'alt', 'cmd'}, 'y')
    end
end)

hs.urlevent.bind('yank-word', function()
    if appIncludes({sublime, atom}) then
        hs.eventtap.keyStroke({}, 'escape')
        hs.eventtap.keyStrokes('yiw')
    else
        hs.eventtap.keyStroke({'shift', 'alt'}, 'left')
        hs.eventtap.keyStroke({'cmd'}, 'c')
        hs.eventtap.keyStroke({}, 'right')
    end
end)

hs.urlevent.bind('yank-toEndOfLine', function()
    if appIncludes({sublime, atom}) then
        hs.eventtap.keyStroke({}, 'escape')
        hs.eventtap.keyStrokes('y')
        hs.eventtap.keyStroke({'shift'}, '4')
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'right')
        hs.eventtap.keyStroke({'cmd'}, 'c')
        hs.eventtap.keyStroke({}, 'left')
    end
end)

hs.urlevent.bind('yank-toBeginningOfLine', function()
    if appIncludes({sublime, atom}) then
        hs.eventtap.keyStroke({}, 'escape')
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'left')
        hs.eventtap.keyStrokes('y')
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'left')
        hs.eventtap.keyStroke({'cmd'}, 'c')
        hs.eventtap.keyStroke({}, 'right')
    end
end)

hs.urlevent.bind('yank-line', function()
    if appIncludes({sublime, atom}) then
        hs.eventtap.keyStroke({}, 'escape')
        hs.eventtap.keyStrokes('yy')
    else
        hs.eventtap.keyStroke({'cmd'}, 'left')
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'right')
        hs.eventtap.keyStroke({'cmd'}, 'c')
        hs.eventtap.keyStroke({}, 'right')
    end
end)

hs.urlevent.bind('yank-character', function()
    if appIncludes({sublime, atom}) then
        hs.eventtap.keyStroke({}, 'escape')
        hs.eventtap.keyStrokes('yl')
    else
        hs.eventtap.keyStroke({'shift'}, 'left')
        hs.eventtap.keyStroke({'cmd'}, 'c')
        hs.eventtap.keyStroke({}, 'right')
    end
end)

hs.urlevent.bind('yank-all', function()
    hs.eventtap.keyStroke({'cmd'}, 'A')
    hs.eventtap.keyStroke({'cmd'}, 'C')
    hs.eventtap.keyStroke({}, 'Right')
end)

hs.urlevent.bind('paste-toEndOfWord', function()
    if appIncludes({sublime, atom}) then
        hs.eventtap.keyStroke({}, 'escape')
        hs.eventtap.keyStrokes('vep')
    else
        hs.eventtap.keyStroke({'shift', 'alt'}, 'right')
        hs.eventtap.keyStroke({'cmd'}, 'v')
    end
end)

hs.urlevent.bind('paste-word', function()
    if appIncludes({sublime, atom}) then
        hs.eventtap.keyStroke({}, 'escape')
        hs.eventtap.keyStrokes('viwp')
    else
        hs.eventtap.keyStroke({'shift', 'alt'}, 'left')
        hs.eventtap.keyStroke({'cmd'}, 'v')
    end
end)

hs.urlevent.bind('paste-toEndOfLine', function()
    if appIncludes({sublime, atom}) then
        hs.eventtap.keyStroke({}, 'escape')
        hs.eventtap.keyStrokes('v')
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'right')
        hs.eventtap.keyStrokes('p')
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'right')
        hs.eventtap.keyStroke({'cmd'}, 'v')
    end
end)

hs.urlevent.bind('paste-toBeginningOfLine', function()
    if appIncludes({sublime, atom}) then
        hs.eventtap.keyStroke({}, 'escape')
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'left')
        hs.eventtap.keyStrokes('p')
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'left')
        hs.eventtap.keyStroke({'cmd'}, 'v')
    end
end)

hs.urlevent.bind('paste-line', function()
    if appIncludes({sublime, atom}) then
        hs.eventtap.keyStroke({}, 'escape')
        hs.eventtap.keyStroke({'shift'}, 'v')
        hs.eventtap.keyStrokes('p')
    else
        hs.eventtap.keyStroke({'cmd'}, 'left')
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'right')
        hs.eventtap.keyStroke({'cmd'}, 'v')
    end
end)

hs.urlevent.bind('paste-character', function()
    if appIncludes({sublime, atom}) then
        hs.eventtap.keyStroke({}, 'escape')
        hs.eventtap.keyStrokes('vp')
    else
        hs.eventtap.keyStroke({'shift'}, 'left')
        hs.eventtap.keyStroke({'cmd'}, 'v')
    end
end)

hs.urlevent.bind('change-toEndOfWord', function()
    if appIncludes({sublime, atom}) then
        hs.eventtap.keyStroke({}, 'escape')
        hs.eventtap.keyStrokes('ce')
    else
        hs.eventtap.keyStroke({'shift', 'alt'}, 'right')
        hs.eventtap.keyStroke({}, 'delete')
    end
end)

hs.urlevent.bind('change-word', function()
    if appIncludes({sublime, atom}) then
        hs.eventtap.keyStroke({}, 'escape')
        hs.eventtap.keyStrokes('ciw')
    else
        hs.eventtap.keyStroke({'alt'}, 'delete')
    end
end)

hs.urlevent.bind('change-toEndOfLine', function()
    if appIncludes({sublime, atom}) then
        hs.eventtap.keyStroke({}, 'escape')
        hs.eventtap.keyStroke({'shift'}, 'c')
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'right')
        hs.eventtap.keyStroke({}, 'delete')
    end
end)

hs.urlevent.bind('change-toBeginningOfLine', function()
    if appIncludes({sublime, atom}) then
        hs.eventtap.keyStroke({}, 'escape')
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'left')
        hs.eventtap.keyStrokes('c')
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'left')
        hs.eventtap.keyStroke({}, 'delete')
    end
end)

hs.urlevent.bind('change-line', function()
    if appIncludes({sublime, atom}) then
        hs.eventtap.keyStroke({}, 'escape')
        hs.eventtap.keyStrokes('cc')
    else
        hs.eventtap.keyStroke({'cmd'}, 'left')
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'right')
        hs.eventtap.keyStroke({}, 'delete')
    end
end)

hs.urlevent.bind('change-character', function()
    if appIncludes({sublime, atom}) then
        hs.eventtap.keyStroke({}, 'escape')
        hs.eventtap.keyStrokes('vc')
    else
        hs.eventtap.keyStroke({}, 'delete')
    end
end)

hs.urlevent.bind('destroy-toEndOfWord', function()
    if appIncludes({sublime, atom}) then
        hs.eventtap.keyStroke({}, 'escape')
        hs.eventtap.keyStrokes('de')
    else
        hs.eventtap.keyStroke({'shift', 'alt'}, 'right')
        hs.eventtap.keyStroke({}, 'delete')
    end
end)

hs.urlevent.bind('destroy-word', function()
    if appIncludes({sublime, atom}) then
        hs.eventtap.keyStroke({}, 'escape')
        hs.eventtap.keyStrokes('diw')
    elseif appIs(iterm) then
        hs.eventtap.keyStroke({'ctrl'}, 'w')
    else
        hs.eventtap.keyStroke({'alt'}, 'delete')
    end
end)

hs.urlevent.bind('destroy-toEndOfLine', function()
    if appIncludes({sublime, atom}) then
        hs.eventtap.keyStroke({}, 'escape')
        hs.eventtap.keyStroke({'shift'}, 'd')
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'right')
        hs.eventtap.keyStroke({}, 'delete')
    end
end)

hs.urlevent.bind('destroy-toBeginningOfLine', function()
    if appIncludes({sublime, atom}) then
        hs.eventtap.keyStroke({}, 'escape')
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'left')
        hs.eventtap.keyStrokes('d')
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'left')
        hs.eventtap.keyStroke({}, 'delete')
    end
end)

hs.urlevent.bind('destroy-line', function()
    if appIncludes({sublime, atom}) then
        hs.eventtap.keyStroke({}, 'escape')
        hs.eventtap.keyStrokes('dd')
    else
        hs.eventtap.keyStroke({'cmd'}, 'left')
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'right')
        hs.eventtap.keyStroke({}, 'delete')
    end
end)

hs.urlevent.bind('destroy-character', function()
    if appIncludes({sublime, atom}) then
        hs.eventtap.keyStroke({}, 'escape')
        hs.eventtap.keyStrokes('x')
    else
        hs.eventtap.keyStroke({}, 'delete')
    end
end)

hs.urlevent.bind('select-inside-word', function()
    if appIncludes({sublime, atom}) then
        hs.eventtap.keyStroke({}, 'escape')
        hs.eventtap.keyStrokes('viw')
    else
        hs.eventtap.keyStroke({'shift', 'alt'}, 'left')
    end
end)

hs.urlevent.bind('select-inside-line', function()
    if appIncludes({sublime, atom}) then
        hs.eventtap.keyStroke({}, 'escape')
        hs.eventtap.keyStroke({'shift'}, 'v')
    else
        hs.eventtap.keyStroke({'cmd'}, 'left')
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'right')
    end
end)

hs.urlevent.bind('select-inside-character', function()
    if appIncludes({sublime, atom}) then
        hs.eventtap.keyStroke({}, 'escape')
        hs.eventtap.keyStrokes('v')
    else
        hs.eventtap.keyStroke({'shift'}, 'left')
    end
end)

hs.urlevent.bind('select-until-endOfWord', function()
    if appIncludes({sublime, atom}) then
        hs.eventtap.keyStroke({}, 'escape')
        hs.eventtap.keyStrokes('ve')
    else
        hs.eventtap.keyStroke({'shift', 'alt'}, 'right')
    end
end)

hs.urlevent.bind('select-until-nextWord', function()
    if appIncludes({sublime, atom}) then
        hs.eventtap.keyStroke({}, 'escape')
        hs.eventtap.keyStrokes('vw')
    else
        hs.eventtap.keyStroke({'shift', 'alt'}, 'right')
        hs.eventtap.keyStroke({'shift', 'alt'}, 'right')
    end
end)

hs.urlevent.bind('select-until-endOfLine', function()
    if appIncludes({sublime, atom}) then
        hs.eventtap.keyStroke({}, 'escape')
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'right')
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'right')
    end
end)

hs.urlevent.bind('select-until-beginningOfLine', function()
    if appIncludes({sublime, atom}) then
        hs.eventtap.keyStroke({}, 'escape')
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'left')
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'left')
    end
end)

return obj
