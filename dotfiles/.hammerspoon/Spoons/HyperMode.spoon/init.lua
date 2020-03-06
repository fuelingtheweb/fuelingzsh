local obj = {}
obj.__index = obj

hs.urlevent.bind('hyper-copy', function()
    text = getSelectedText(true)
    if text then
        -- Already in clipboard, do not reset
    elseif appIs(spotify) then
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
    elseif appIs(chrome) then
        if stringContains('Chrome Web Store', currentTitle()) then
            hs.eventtap.keyStroke({'cmd'}, 'L');
            hs.eventtap.keyStroke({'cmd'}, 'C');
            hs.eventtap.keyStrokes('javascript:(function(){})();');
            hs.eventtap.keyStroke({}, 'return');
        else
            hs.eventtap.keyStrokes('yy')
        end
    end
end)

hs.urlevent.bind('hyper-copyTextArea', function()
    if appIs(notion) then
        hs.eventtap.keyStroke({'cmd'}, 'A')
        hs.eventtap.keyStroke({'cmd'}, 'C')
        hs.eventtap.keyStroke({}, 'Right')
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'Up')
        hs.eventtap.keyStroke({'cmd'}, 'C')
        hs.eventtap.keyStroke({}, 'Right')
    end
end)

hs.urlevent.bind('hyper-openAnything', function()
    if appIs(notion) or appIs(atom) or appIs(sublime) or appIs(sublimeMerge) or appIs(tableplus) then
        hs.eventtap.keyStroke({'cmd'}, 'p')
    elseif appIs(finder) then
        triggerAlfredSearch('open')
    elseif appIs(discord) then
        hs.eventtap.keyStroke({'cmd'}, 'k')
    elseif appIs(spotify) then
        triggerAlfredWorkflow('.spot_mini', 'com.vdesabou.spotify.mini.player')
    elseif appIs(teams) then
        hs.eventtap.keyStroke({'cmd'}, 'e')
    elseif appIs(chrome) then
        -- For dev tools
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'p')
    end
end)

hs.urlevent.bind('hyper-commandPalette', function()
    if appIs(atom) or appIs(sublime) or appIs(sublimeMerge) then
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'p')
    else
        triggerAlfredWorkflow('search', 'com.tedwise.menubarsearch')
    end
end)

hs.urlevent.bind('hyper-previousPage', function()
    if appIs(spotify) then
        hs.eventtap.keyStroke({'alt', 'cmd'}, 'Left')
    elseif appIs(discord) then
        hs.eventtap.keyStroke({'cmd'}, 'K')
        hs.eventtap.keyStroke({}, 'return')
    elseif appIs(atom) then
         -- Atom: Cursor History: Previous
        hs.eventtap.keyStroke({'shift', 'alt'}, 'I')
    else
        hs.eventtap.keyStroke({'cmd'}, '[')
    end
end)

hs.urlevent.bind('hyper-previousTab', function()
    if appIs(tableplus) then
        hs.eventtap.keyStroke({'cmd'}, '[')
    elseif appIs(teams) then
        -- Teams: Move to next conversation
        hs.eventtap.keyStroke({'alt'}, 'Down')
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, '[')
    end
end)

hs.urlevent.bind('hyper-nextTab', function()
    if appIs(tableplus) then
        hs.eventtap.keyStroke({'cmd'}, ']')
    elseif appIs(teams) then
        -- Teams: Move to previous conversation
        hs.eventtap.keyStroke({'alt'}, 'Up')
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, ']')
    end
end)

hs.urlevent.bind('hyper-nextPage', function()
    if appIs(spotify) then
        hs.eventtap.keyStroke({'alt', 'cmd'}, 'Right')
    elseif appIs(iterm) then
        -- Autocomplete to the end of the line
        hs.eventtap.keyStroke({'cmd'}, 'L')
    elseif appIs(atom) then
         -- Atom: Cursor History: Next
        hs.eventtap.keyStroke({'ctrl'}, 'O')
    else
        hs.eventtap.keyStroke({'cmd'}, ']')
    end
end)

hs.urlevent.bind('hyper-shortcat', function()
    bundle = 'com.sproutcube.Shortcat'

    if hs.application.get(bundle) == nil then
        hs.application.open(bundle)
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'space')
    end
end)

hs.urlevent.bind('hyper-jumpTo', function()
    if appIs(atom) then
        hs.eventtap.keyStroke({'shift'}, 'return')
    elseif appIs(sublime) then
        hs.eventtap.keyStroke({'shift', 'cmd'}, '.')
    else
        hs.eventtap.keyStroke({'ctrl'}, 'space')
    end
end)

return obj
