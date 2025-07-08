local Brave = {}
Brave.__index = Brave

function Brave.open(url)
    hs.execute('"/Applications/Brave Browser.app/Contents/MacOS/Brave Browser" "' .. url .. '" --profile-directory="Default"')
    cm.Window.maximizeAfterDelay()
end

function Brave.openInNewWindow(url)
    hs.execute('"/Applications/Brave Browser.app/Contents/MacOS/Brave Browser" "' .. url .. '" --profile-directory="Default" --new-window')
    cm.Window.maximizeAfterDelay()
end

function Brave.openIncognito(url)
    hs.execute('"/Applications/Brave Browser.app/Contents/MacOS/Brave Browser" "' .. url .. '" --incognito --profile-directory="Default"')
    cm.Window.maximizeAfterDelay()
end

function Brave.urlContains(needle)
    return str.contains(needle:gsub('-', '%%-'), Brave.currentUrl())
end

function Brave.currentUrl()
    return fn.clipboard.preserve(Brave.copyUrl)
end

function Brave.updateUrl(needle, newUrl)
    if Brave.urlContains(needle) then
        hs.osascript.applescript([[
            tell application "Brave Browser"
                set URL of active tab of front window to "]] .. newUrl .. [["
            end tell
        ]])

        return true
    end
end

function Brave.changeUrl(newUrl)
    hs.osascript.applescript([[
        tell application "Brave Browser"
            set URL of active tab of front window to "]] .. newUrl .. [["
        end tell
    ]])
end

function Brave.copyUrl()
    hs.osascript.applescript([[
        tell application "Brave Browser"
            set theUrl to URL of active tab of front window
        end tell

        set the clipboard to theUrl
    ]])
end

function Brave.searchGoogle(query)
    Brave.openIncognito(Brave.getUrlForQuery(query))
end

function Brave.getUrlForQuery(query)
    if str.startsWith('http', query) then
        return query
    end

    return 'https://www.google.com/search?q=' .. query
end

return Brave
