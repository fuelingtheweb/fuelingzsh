local Chrome = {}
Chrome.__index = Chrome

function Chrome.open(url)
    hs.execute('"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" "' .. url .. '" --profile-directory="Default"')
    cm.Window.maximizeAfterDelay()
end

function Chrome.openInNewWindow(url)
    hs.execute('"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" "' .. url .. '" --profile-directory="Default" --new-window')
    cm.Window.maximizeAfterDelay()
end

function Chrome.openIncognito(url)
    hs.execute('"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" "' .. url .. '" --incognito --profile-directory="Default"')
    cm.Window.maximizeAfterDelay()
end

function Chrome.urlContains(needle)
    return stringContains(needle:gsub('-', '%%-'), Chrome.currentUrl())
end

function Chrome.currentUrl()
    original = hs.pasteboard.getContents()
    hs.pasteboard.clearContents()

    fn.Chrome.copyUrl()
    url = hs.pasteboard.getContents()

    hs.pasteboard.setContents(original)

    return url
end

function Chrome.updateUrl(needle, newUrl)
    Chrome.copyUrl()

    if stringContains(needle, hs.pasteboard.getContents()) then
        hs.osascript.applescript([[
            tell application "Google Chrome"
                set URL of active tab of front window to "]] .. newUrl .. [["
            end tell
        ]])

        return true
    end
end

function Chrome.copyUrl()
    hs.osascript.applescript([[
        tell application "Google Chrome"
            set theUrl to URL of active tab of front window
        end tell

        set the clipboard to theUrl
    ]])
end

function Chrome.searchGoogle(query)
    Chrome.openIncognito(Chrome.getUrlForQuery(query))
end

function Chrome.getUrlForQuery(query)
    if startsWith('http', query) then
        return query
    end

    return 'https://www.google.com/search?q=' .. query
end

return Chrome
