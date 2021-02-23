local GoogleMode = {}
GoogleMode.__index = GoogleMode

function GoogleMode.y()
    hs.execute("open -g 'hammerspoon://custom-open?key=Y'")
end

function GoogleMode.u()
end

function GoogleMode.i()
    openInChrome('https://inbox.google.com')
end

function GoogleMode.o()
    GoogleMode.toggleIncognito()
end

function GoogleMode.p()
    -- Chrome: Show profiles list
    hs.eventtap.keyStroke({'shift', 'cmd'}, 'm')
end

function GoogleMode.open_bracket()
    -- Chrome: Group Tab
    hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 'g')
end

function GoogleMode.close_bracket()
end

function GoogleMode.h()
    triggerAlfredWorkflow('history', 'com.thomasupton.chrome-history')
end

function GoogleMode.j()
end

function GoogleMode.k()
end

function GoogleMode.l()
    -- Lastpass
    hs.eventtap.keyStroke({'shift', 'ctrl', 'alt', 'cmd'}, 'l')
end

function GoogleMode.semicolon()
    -- Chrome: Tab Manager
    hs.eventtap.keyStroke({'shift', 'cmd'}, 'm')
end

function GoogleMode.quote()
    GoogleMode.openAndReload()
end

function GoogleMode.return_or_enter()
    -- Chrome: Dismiss downloads bar
    hs.eventtap.keyStroke({'alt'}, 'w')
end

function GoogleMode.n()
    -- Chrome: Save Bookmark
    hs.eventtap.keyStroke({'cmd'}, 'd')
end

function GoogleMode.m()
    triggerAlfredWorkflow('bookmarks', 'com.chrome.bookmarks')
end

function GoogleMode.comma()
    -- Chrome: Toggle Dev Tools
    hs.eventtap.keyStroke({'alt', 'cmd'}, 'i')
end

function GoogleMode.period()
    -- Chrome: Toggle Dev Tools docking
    hs.eventtap.keyStroke({'shift', 'cmd'}, 'd')
end

function GoogleMode.slash()
end

function GoogleMode.right_shift()
end

function GoogleMode.spacebar()
end

function GoogleMode.openAndReload()
    hs.application.get(apps['chrome']):activate()
    hs.eventtap.keyStroke({'cmd'}, 'R')
end

function GoogleMode.toggleIncognito()
    if customUpdateChromeUrl() then
        return;
    end

    hs.osascript.applescript([[
        tell application "Google Chrome"
            set theUrl to URL of active tab of front window
            set theMode to GoogleMode of front window
        end tell

        if theMode is equal to "normal" then
            do shell script "'/Applications/Google Chrome.app/Contents/MacOS/Google Chrome' --incognito --profile-directory='Default' " & quoted form of theUrl
        else
            do shell script "'/Applications/Google Chrome.app/Contents/MacOS/Google Chrome' --profile-directory='Default' " & quoted form of theUrl
        end if
    ]])
end

return GoogleMode
