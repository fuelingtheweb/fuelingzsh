local TablePlus = {}
TablePlus.__index = TablePlus

function TablePlus.open(url)
    hs.execute('open "' .. url .. '"')
end

function TablePlus.closeWindow()
    hs.osascript.applescript([[
        tell application "System Events"
            tell process "TablePlus"
                click menu item "Close" of menu "File" of menu bar 1
            end tell
        end tell
    ]])
end

return TablePlus
