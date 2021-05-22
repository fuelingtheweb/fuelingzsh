local OpenMode = {}
OpenMode.__index = OpenMode

OpenMode.lookup = {
    tab = 'customOpen',
    q = 'customOpen',
    w = 'customOpen',
    e = 'inSublime',
    r = 'inAtom',
    t = 'customOpen',
    caps_lock = 'customOpen',
    a = 'aliases',
    s = 'snippets',
    d = 'downloads',
    f = 'customOpen',
    g = 'inChrome',
    left_shift = 'customOpen',
    z = 'fuelingzsh',
    x = 'inTinkerwell',
    c = 'inSublimeMerge',
    v = 'inTablePlus',
    b = 'inFinder',

    h = 'hammerspoon',
    k = 'karabiner',

    spacebar = 'customOpen',
}

function OpenMode.customOpen(key)
    hs.execute("open -g 'hammerspoon://custom-open?key=" .. key .. "'")
end

function OpenMode.aliases()
    openInSublime('~/.fuelingzsh/aliases')
    hs.timer.doAfter(0.1, spoon.HyperMode.open)
end

function OpenMode.snippets()
    openInSublime('~/.fuelingzsh/custom/espanso/default.yml')
end

function OpenMode.downloads()
    hs.execute('open ~/Downloads')
end

function OpenMode.hammerspoon()
    openInSublime('~/.hammerspoon')
    hs.timer.doAfter(0.1, spoon.HyperMode.open)
end

function OpenMode.fuelingzsh()
    openInSublime('~/.fuelingzsh')
    hs.timer.doAfter(0.1, spoon.HyperMode.open)
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

function OpenMode.inSublime()
    if appIs(iterm) then
        typeAndEnter('st.')
    else
        path = currentTitle():match('~%S+')

        if not path then
           return;
        end

        openInSublime(path)
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
