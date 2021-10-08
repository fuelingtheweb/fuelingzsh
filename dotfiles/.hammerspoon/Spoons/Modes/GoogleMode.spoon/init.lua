local GoogleMode = {}
GoogleMode.__index = GoogleMode

GoogleMode.lookup = {
    y = 'custom',
    u = 'viewSource',
    i = 'inbox',
    o = 'toggleIncognito',
    p = 'profiles',
    open_bracket = 'groupTab',
    close_bracket = nil,
    h = 'history',
    j = nil,
    k = nil,
    l = 'lastpass',
    semicolon = 'tabManager',
    quote = 'openAndReload',
    return_or_enter = 'dismissDownloadsBar',
    n = 'newBookmark',
    m = 'bookmarks',
    comma = 'toggleDevTools',
    period = 'toggleDevToolsDocking',
    slash = nil,
    right_shift = nil,
    spacebar = nil,
}

function GoogleMode.custom(key)
    hs.execute("open -g 'hammerspoon://custom-open?key=" .. key .. "'")
end

function GoogleMode.inbox()
    openInChrome('https://inbox.google.com')
end

function GoogleMode.profiles()
    fastKeyStroke({'shift', 'cmd'}, 'm')
end

function GoogleMode.groupTab()
    fastKeyStroke({'ctrl', 'alt', 'cmd'}, 'g')
end

function GoogleMode.history()
    triggerAlfredWorkflow('history', 'com.thomasupton.chrome-history')
end

function GoogleMode.lastpass()
    fastKeyStroke({'ctrl', 'alt', 'cmd'}, 'p')
end

function GoogleMode.tabManager()
    fastKeyStroke({'shift', 'cmd'}, 'm')
end

function GoogleMode.dismissDownloadsBar()
    fastKeyStroke({'alt'}, 'w')
end

function GoogleMode.newBookmark()
    fastKeyStroke({'cmd'}, 'd')
end

function GoogleMode.bookmarks()
    triggerAlfredWorkflow('bookmarks', 'com.chrome.bookmarks')
end

function GoogleMode.toggleDevTools()
    fastKeyStroke({'alt', 'cmd'}, 'i')
end

function GoogleMode.toggleDevToolsDocking()
    fastKeyStroke({'shift', 'cmd'}, 'd')
end

function GoogleMode.openAndReload()
    hs.application.get(apps['chrome']):activate()
    fastKeyStroke({'cmd'}, 'r')
end

function GoogleMode.toggleIncognito()
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

function GoogleMode.viewSource()
    fastKeyStroke({'alt', 'cmd'}, 'u')
end

return GoogleMode
