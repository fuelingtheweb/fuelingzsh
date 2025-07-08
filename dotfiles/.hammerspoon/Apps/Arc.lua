local Arc = {}
Arc.__index = Arc

function Arc.getSpaceIndex(name)
    local ok, result, descriptor = hs.osascript.applescript([[
        set _space_index to ""
        tell application "Arc"
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

function Arc._chooseSpace()
    return function(url)
        ArcModal.open(url)
    end
end

function Arc._openIn(spaceName)
    return function(url)
        Arc.openIn(url, spaceName)
    end
end

function Arc.open(url)
    Arc.openIn(url, 'Misc')
end

function Arc.openIn(url, spaceName)
    if spaceName == 'Current' then
        hs.osascript.applescript([[
            tell application "Arc"
                tell front window
                    make new tab with properties {URL:"]] .. url .. [["}
                end tell

                activate
            end tell
        ]])
    else
        local spaceIndex = Arc.getSpaceIndex(spaceName)

        if not spaceIndex or not url then
            return
        end

        hs.osascript.applescript([[
            tell application "Arc"
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

function Arc.urlContains(needle)
    return str.contains(needle:gsub('-', '%%-'), Arc.currentUrl())
end

function Arc.currentUrl()
    return fn.clipboard.preserve(function ()
        hs.osascript.applescript([[
            tell application "Arc"
                set currentURL to URL of active tab of window 1
                set the clipboard to currentUrl
            end tell
        ]])
        -- set currentURL to URL of active tab of window 1
        -- set currentTitle to title of active tab of window 1
    end)
end

function Arc.copyUrl()
    ks.shiftCmd('c')
end

function Arc.copyMarkdownUrl()
    if is.github() then
        ks.shiftAltCmd('c')
    else
        Arc.copyUrl()
    end
end

return Arc
