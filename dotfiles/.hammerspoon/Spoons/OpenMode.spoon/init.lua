local obj = {}
obj.__index = obj

hs.urlevent.bind('open-inSublimeMerge', function()
    if appIs(iterm) then
        return typeAndEnter('smerge .')
    end

    path = currentTitle():match('~%S+')

    if path then
        hs.execute('/usr/local/bin/smerge "' .. path .. '"')
    end
end)

hs.urlevent.bind('open-inAtom', function()
    if appIs(iterm) then
        typeAndEnter('atom .')
    else
        triggerAlfredWorkflow('projects', 'com.fuelingtheweb.commands')
    end
end)

hs.urlevent.bind('open-inChrome', function()
    text = getSelectedText()
    if not appIncludes({atom, sublime}) and text then
        runGoogleSearch(text)
    elseif appIs(chrome) then
        copyChromeUrl()
        openInChrome(getSelectedText())
    else
        ProjectManager.openUrlForCurrent()
    end
end)

hs.urlevent.bind('open-inTablePlus', function()
    customOpenInTablePlus()
end)

hs.urlevent.bind('open-inFinder', function()
    if appIs(iterm) then
        typeAndEnter('o.')
    else
        path = currentTitle():match('~%S+')
        if not path then
           return;
        end
        if appIs(atom) then
            hs.execute('open ' .. path)
        else
            hs.execute('open -R ' .. path)
        end
    end
end)

hs.urlevent.bind('open-inTinkerwell', function()
    if appIs(iterm) then
        return typeAndEnter('tinkerwell .')
    end

    path = currentTitle():match('~%S+')

    if path then
        executeFromFuelingZsh('tinkerwell "' .. path .. '"')
    end
end)

hs.urlevent.bind('open-karabiner', function()
    openInSublime('~/.fuelingzsh/karabiner/goku')
    openInSublime('~/.fuelingzsh/karabiner/goku/main.edn')
end)

return obj
