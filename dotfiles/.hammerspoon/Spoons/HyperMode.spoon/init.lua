local HyperMode = {}
HyperMode.__index = HyperMode

function HyperMode.y()
    HyperMode.copy()
end

function HyperMode.u()
    HyperMode.copyTextArea()
end

function HyperMode.i()
end

function HyperMode.o()
    HyperMode.open()
end

function HyperMode.p()
    HyperMode.paste()
end

function HyperMode.open_bracket()
    HyperMode.commandPalette()
end

function HyperMode.close_bracket()
end

function HyperMode.h()
    HyperMode.previousPage()
end

function HyperMode.j()
    HyperMode.previousTab()
end

function HyperMode.k()
    HyperMode.nextTab()
end

function HyperMode.l()
    HyperMode.nextPage()
end

function HyperMode.semicolon()
    -- Alfred
    hs.eventtap.keyStroke({'alt'}, 'z')
end

function HyperMode.quote()
    -- Alfred Clipboard
    hs.eventtap.keyStroke({'alt'}, 'c')
end

function HyperMode.return_or_enter()
    hs.eventtap.keyStroke({}, 'caps_lock')
end

function HyperMode.n()
    HyperMode.new()
end

function HyperMode.m()
end

function HyperMode.comma()
    HyperMode.jumpTo()
end

function HyperMode.period()
end

function HyperMode.slash()
end

function HyperMode.right_shift()
end

function HyperMode.spacebar()
end

function HyperMode.copy()
    text = getSelectedText(true)
    if appIs(spotify) then
        hs.osascript.applescript([[
            tell application "Spotify"
                set theTrack to name of the current track
                set theArtist to artist of the current track
                set theAlbum to album of the current track
                set track_id to id of current track
            end tell

            set AppleScript's text item delimiters to ":"
            set track_id to third text item of track_id
            set AppleScript's text item delimiters to {""}
            set realurl to ("https://open.spotify.com/track/" & track_id)

            set theString to theTrack & " by " & theArtist & ": " & realurl
            set the clipboard to theString
        ]])
    elseif text then
        -- Already in clipboard, do not reset
    elseif appIs(chrome) then
        copyChromeUrl()
    end
end

function HyperMode.open()
    if appIncludes({notion, atom, sublime, sublimeMerge, tableplus, invoker}) then
        hs.eventtap.keyStroke({'cmd'}, 'p')

        if inCodeEditor() then
            TextManipulation.disableVim()
        end
    elseif appIs(discord) then
        hs.eventtap.keyStroke({'cmd'}, 'k')
    elseif appIs(spotify) then
        triggerAlfredWorkflow('spot_mini', 'com.vdesabou.spotify.mini.player')
    elseif appIs(chrome) then
        hs.eventtap.keyStroke({'shift'}, 'O')
    else
        hs.eventtap.keyStroke({'cmd'}, 'O')
    end
end

function HyperMode.new()
    if appIs(atom) then
        TextManipulation.disableVim()
        hs.eventtap.keyStroke({'alt', 'cmd'}, 'O')
    elseif appIs(sublime) then
        TextManipulation.disableVim()
        hs.eventtap.keyStroke({'alt', 'cmd'}, 'N')
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'N')
    end
end

function HyperMode.copyTextArea()
    if appIs(notion) then
        hs.eventtap.keyStroke({'cmd'}, 'A')
        hs.eventtap.keyStroke({'cmd'}, 'C')
        hs.eventtap.keyStroke({}, 'Right')
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'Up')
        hs.eventtap.keyStroke({'cmd'}, 'C')
        hs.eventtap.keyStroke({}, 'Right')
    end
end

function HyperMode.commandPalette()
    if appIncludes({atom, sublime, sublimeMerge}) then
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'p')

        if inCodeEditor() then
            TextManipulation.disableVim()
        end
    else
        triggerAlfredWorkflow('search', 'com.tedwise.menubarsearch')
    end
end

function HyperMode.previousPage()
    if appIs(spotify) then
        hs.eventtap.keyStroke({'alt', 'cmd'}, 'Left')
    elseif appIs(discord) then
        hs.eventtap.keyStroke({'cmd'}, 'K')
        hs.eventtap.keyStroke({}, 'return')
    elseif appIs(atom) then
         -- Atom: Cursor History: Previous
        hs.eventtap.keyStroke({'shift', 'alt'}, 'I')
    elseif appIs(sublime) then
        hs.eventtap.keyStroke({'ctrl'}, '-')
    elseif appIs(iterm) then
        typeAndEnter('cdp')
    else
        hs.eventtap.keyStroke({'cmd'}, '[')
    end
end

function HyperMode.previousTab()
    if appIs(tableplus) then
        hs.eventtap.keyStroke({'cmd'}, '[')
    elseif appIncludes({teams, discord}) then
        -- Teams: Move to next conversation / channel
        hs.eventtap.keyStroke({'alt'}, 'Down')
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, '[')
    end
end

function HyperMode.nextTab()
    if appIs(tableplus) then
        hs.eventtap.keyStroke({'cmd'}, ']')
    elseif appIncludes({teams, discord}) then
        -- Teams: Move to previous conversation / channel
        hs.eventtap.keyStroke({'alt'}, 'Up')
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, ']')
    end
end

function HyperMode.nextPage()
    if appIs(spotify) then
        hs.eventtap.keyStroke({'alt', 'cmd'}, 'Right')
    elseif appIs(iterm) then
        -- Autocomplete to the end of the line
        hs.eventtap.keyStroke({'cmd'}, 'L')
    elseif appIs(atom) then
         -- Atom: Cursor History: Next
        hs.eventtap.keyStroke({'ctrl'}, 'O')
    elseif appIs(sublime) then
        hs.eventtap.keyStroke({'ctrl', 'shift'}, '-')
    else
        hs.eventtap.keyStroke({'cmd'}, ']')
    end
end

function HyperMode.jumpTo()
    if appIs(atom) then
        hs.eventtap.keyStroke({'shift'}, 'return')
    elseif appIs(sublime) then
        hs.eventtap.keyStroke({'shift', 'cmd'}, '.')
    else
        hs.eventtap.keyStroke({'ctrl'}, 'space')
    end
end

function HyperMode.paste()
    hs.eventtap.keyStroke({'cmd'}, 'v', 0)

    if titleContains('Slack | ') then
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'f', 0)
    end
end

return HyperMode
