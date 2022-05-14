local Google = {}
Google.__index = Google

Google.lookup = {
    y = 'custom',
    u = 'viewSource',
    i = 'inbox',
    o = 'toggleIncognito',
    p = 'profiles',
    open_bracket = 'openLastpass',
    close_bracket = 'groupTab',
    h = 'history',
    j = 'nextGitConflict',
    k = 'previousGitConflict',
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
    spacebar = 'addPrComment',
}

function Google.custom(key)
    hs.execute("open -g 'hammerspoon://custom-open?key=" .. key .. "'")
end

function Google.inbox()
    fn.Chrome.open('https://inbox.google.com')
end

function Google.profiles()
    ks.shiftCmd('m')
end

function Google.groupTab()
    ks.super('g')
end

function Google.history()
    if is.vscode() then
        ks.shiftAltCmd('g').shiftAltCmd('h')
    else
        fn.Alfred.run('history', 'com.thomasupton.chrome-history')
    end
end

function Google.lastpass()
    ks.super('p')
end

function Google.tabManager()
    ks.shiftCmd('m')
end

function Google.dismissDownloadsBar()
    ks.alt('w')
end

function Google.newBookmark()
    if is.vscode() then
        ks.type('```suggestion').enter().enter().type('```').up()
    else
        ks.cmd('d')
    end
end

function Google.bookmarks()
    fn.Alfred.run('bookmarks', 'com.chrome.bookmarks')
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

function Google.nextGitConflict()
    ks.slow().shiftAltCmd('g').slow().shiftAltCmd('j')
end

function Google.previousGitConflict()
    ks.slow().shiftAltCmd('g').slow().shiftAltCmd('k')
end

function Google.openLastpass()
    ks.shiftCmd('l')
end

function Google.addPrComment()
    ks.shiftAltCmd('g').shiftAltCmd('space')
end

return Google
