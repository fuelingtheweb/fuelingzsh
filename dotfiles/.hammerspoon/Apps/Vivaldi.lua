local Vivaldi = {}
Vivaldi.__index = Vivaldi

function Vivaldi.open(url)
    hs.osascript.applescript([[
        tell application "Vivaldi"
            tell front window
                make new tab with properties {URL:"]] .. url .. [["}
            end tell

            activate
        end tell
    ]])
end

function Vivaldi.urlContains(needle)
    return str.contains(needle:gsub('-', '%%-'), Vivaldi.currentUrl())
end

function Vivaldi.currentUrl()
    return fn.clipboard.preserve(function ()
        hs.osascript.applescript([[
            tell application "Vivaldi"
                set currentURL to URL of active tab of window 1
                set the clipboard to currentUrl
            end tell
        ]])
        -- set currentURL to URL of active tab of window 1
        -- set currentTitle to title of active tab of window 1
    end)
end

function Vivaldi.copyUrl()
    ks.shiftCmd('c')
end

function Vivaldi.copyMarkdownUrl()
    if is.github() then
        ks.shiftAltCmd('c')
    else
        Vivaldi.copyUrl()
    end
end

return Vivaldi
