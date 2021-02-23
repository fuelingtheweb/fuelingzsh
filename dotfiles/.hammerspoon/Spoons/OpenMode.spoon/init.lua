local OpenMode = {}
OpenMode.__index = OpenMode

function OpenMode.a()
    openInSublime('~/.fuelingzsh/aliases')
end

function OpenMode.s()
    openInSublime('~/.fuelingzsh/custom/espanso/default.yml')
end

function OpenMode.d()
    hs.execute('open ~/Downloads')
end

function OpenMode.h()
    openInSublime('~/.hammerspoon')
end

function OpenMode.z()
    openInSublime('~/.fuelingzsh')
end

OpenMode.lookup = {
    r = 'inAtom',
    g = 'inChrome',
    k = 'karabiner',
    x = 'inTinkerwell',
    c = 'inSublimeMerge',
    v = 'inTablePlus',
    b = 'inFinder',
}

function OpenMode.handle(key)
    if OpenMode[key] then
        OpenMode[key]()
    elseif OpenMode.lookup[key] then
        OpenMode[OpenMode.lookup[key]]()
    else
        hs.execute("open -g 'hammerspoon://custom-open?key=" .. key:upper() .. "'")
    end
end

function OpenMode.inSublimeMerge()
    if appIs(iterm) then
        return typeAndEnter('smerge .')
    end

    path = currentTitle():match('~%S+')

    if path then
        hs.execute('/usr/local/bin/smerge "' .. path .. '"')
    end
end

function OpenMode.inAtom()
    if appIs(iterm) then
        typeAndEnter('atom .')
    else
        triggerAlfredWorkflow('projects', 'com.fuelingtheweb.commands')
    end
end

function OpenMode.inChrome()
    text = getSelectedText()
    if not appIncludes({atom, sublime}) and text then
        runGoogleSearch(text)
    elseif appIs(chrome) then
        copyChromeUrl()
        openInChrome(getSelectedText())
    else
        ProjectManager.openUrlForCurrent()
    end
end

function OpenMode.inTablePlus()
    customOpenInTablePlus()
end

function OpenMode.inFinder()
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
end

function OpenMode.inTinkerwell()
    if appIs(iterm) then
        return typeAndEnter('tinkerwell .')
    end

    path = currentTitle():match('~%S+')

    if path then
        executeFromFuelingZsh('tinkerwell "' .. path .. '"')
    end
end

function OpenMode.karabiner()
    openInSublime('~/.fuelingzsh/karabiner/goku')
    openInSublime('~/.fuelingzsh/karabiner/goku/compile.py')
end

return OpenMode
