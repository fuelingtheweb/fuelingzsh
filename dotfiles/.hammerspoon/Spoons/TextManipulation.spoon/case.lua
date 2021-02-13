hs.urlevent.bind('case-dialog', function(eventName, params)
    triggerAlfredWorkflow('case-dialog', 'com.fuelingtheweb.commands', params.to)
end)

hs.urlevent.bind('case-changeFromAlfred', function(eventName, params)
    result = trim(hs.execute('/Users/nathan/.nvm/versions/node/v12.4.0/bin/node /Users/nathan/.fuelingzsh/bin/change-case/bin/index.js "' .. params.to .. '" "' .. params.text .. '"'))
    hs.eventtap.keyStrokes(result)
end)

hs.urlevent.bind('case-change', function(eventName, params)
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 'c', 0)
        hs.eventtap.keyStroke({'ctrl', 'alt'}, params.key, 0)
    else
        text = getSelectedText()

        if not text then
            hs.eventtap.keyStroke({'shift', 'alt'}, 'left', 0)
            text = getSelectedText()
        end

        result = trim(hs.execute('/Users/nathan/.nvm/versions/node/v12.4.0/bin/node /Users/nathan/.fuelingzsh/bin/change-case/bin/index.js "' .. params.to .. '" "' .. text .. '"'))
        hs.eventtap.keyStrokes(result)
    end
end)
