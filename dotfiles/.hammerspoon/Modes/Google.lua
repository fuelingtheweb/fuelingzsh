local Google = {}
Google.__index = Google

Google.lookup = {
    y = 'custom',
    u = 'viewSource',
    i = nil,
    o = 'toggleIncognito',
    p = 'profiles',
    open_bracket = 'openLastpass',
    close_bracket = 'groupTab',
    h = 'history',
    j = nil,
    k = nil,
    l = 'lastpass',
    semicolon = 'tabManager',
    quote = 'hardRefresh',
    return_or_enter = nil,
    n = 'newBookmark',
    m = nil,
    comma = 'toggleDevTools',
    period = 'toggleDevToolsDocking',
    slash = nil,
    right_shift = nil,
    spacebar = nil,
}

function Google.custom(key)
    hs.execute("open -g 'hammerspoon://custom-open?key=" .. key .. "'")
end

function Google.profiles()
    ks.shiftCmd('m')
end

function Google.groupTab()
    ks.super('g')
end

function Google.history()
    fn.Alfred.run('history', 'com.thomasupton.chrome-history')
end

function Google.lastpass()
    ks.super('p')
end

function Google.tabManager()
    ks.shiftCmd('m')
end

function Google.newBookmark()
    ks.cmd('d')
end

function Google.toggleDevTools()
    ks.altCmd('i')
end

function Google.toggleDevToolsDocking()
    ks.shiftCmd('d')
end

function Google.openAndReload()
    hs.application.get(chrome):activate()
    ks.refresh()
end

function Google.toggleIncognito()
    hs.osascript.applescript([[
        tell application "Google Chrome"
            set theUrl to URL of active tab of front window
            set theMode to Mode of front window
        end tell

        if theMode is equal to "normal" then
            do shell script "'/Applications/Google Chrome.app/Contents/MacOS/Google Chrome' --incognito --profile-directory='Default' " & quoted form of theUrl
        else
            do shell script "'/Applications/Google Chrome.app/Contents/MacOS/Google Chrome' --profile-directory='Default' " & quoted form of theUrl
        end if
    ]])
end

function Google.viewSource()
    ks.altCmd('u')
end

function Google.openLastpass()
    ks.shiftCmd('l')
end

function Google.hardRefresh()
    ks.shiftCmd('r')
end

return Google
