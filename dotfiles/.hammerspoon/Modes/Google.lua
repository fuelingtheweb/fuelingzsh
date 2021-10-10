local Google = {}
Google.__index = Google

Google.lookup = {
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

function Google.custom(key)
    hs.execute("open -g 'hammerspoon://custom-open?key=" .. key .. "'")
end

function Google.inbox()
    openInChrome('https://inbox.google.com')
end

function Google.profiles()
    fastKeyStroke({'shift', 'cmd'}, 'm')
end

function Google.groupTab()
    fastKeyStroke({'ctrl', 'alt', 'cmd'}, 'g')
end

function Google.history()
    triggerAlfredWorkflow('history', 'com.thomasupton.chrome-history')
end

function Google.lastpass()
    fastKeyStroke({'ctrl', 'alt', 'cmd'}, 'p')
end

function Google.tabManager()
    fastKeyStroke({'shift', 'cmd'}, 'm')
end

function Google.dismissDownloadsBar()
    fastKeyStroke({'alt'}, 'w')
end

function Google.newBookmark()
    fastKeyStroke({'cmd'}, 'd')
end

function Google.bookmarks()
    triggerAlfredWorkflow('bookmarks', 'com.chrome.bookmarks')
end

function Google.toggleDevTools()
    fastKeyStroke({'alt', 'cmd'}, 'i')
end

function Google.toggleDevToolsDocking()
    fastKeyStroke({'shift', 'cmd'}, 'd')
end

function Google.openAndReload()
    hs.application.get(apps['chrome']):activate()
    fastKeyStroke({'cmd'}, 'r')
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
    fastKeyStroke({'alt', 'cmd'}, 'u')
end

return Google