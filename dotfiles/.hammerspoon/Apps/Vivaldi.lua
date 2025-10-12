local Vivaldi = {}
Vivaldi.__index = Vivaldi

function Vivaldi.getSpaceIndex(name)
    local ok, result, descriptor = hs.osascript.applescript([[
        set _space_index to ""
        tell application "Vivaldi"
            set _space_index to 1

            repeat with _space in spaces of front window
                set _title to get title of _space

                if _title = "]] .. name .. [[" then
                    return _space_index
                end if

                set _space_index to _space_index + 1
            end repeat
        end tell

        return _space_index
    ]])

    if ok then
        return result
    end

    return 1
end

function Vivaldi._chooseSpace()
    return function(url)
        ArcModal.open(url)
    end
end

function Vivaldi._openIn(spaceName)
    return function(url)
        Vivaldi.openIn(url, spaceName)
    end
end

function Vivaldi.open(url)
    -- Vivaldi.openIn(url, 'Misc')
    hs.osascript.applescript([[
        tell application "Vivaldi"
            tell front window
                make new tab with properties {URL:"]] .. url .. [["}
            end tell

            activate
        end tell
    ]])
end

function Vivaldi.openIn(url, spaceName)
    if spaceName == 'Current' then
        hs.osascript.applescript([[
            tell application "Vivaldi"
                tell front window
                    make new tab with properties {URL:"]] .. url .. [["}
                end tell

                activate
            end tell
        ]])
    else
        local spaceIndex = Vivaldi.getSpaceIndex(spaceName)

        if not spaceIndex or not url then
            return
        end

        hs.osascript.applescript([[
            tell application "Vivaldi"
                tell front window
                    tell space ]] .. spaceIndex .. "\n" .. [[
                        make new tab with properties {URL:"]] .. url .. [["}
                    end tell
                end tell

                activate
            end tell
        ]])
    end
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
