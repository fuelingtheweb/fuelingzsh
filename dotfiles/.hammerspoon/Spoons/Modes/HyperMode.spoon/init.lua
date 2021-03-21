local HyperMode = {}
HyperMode.__index = HyperMode

function HyperMode.y()
    Pending.run({
        function()
            HyperMode.copy()
        end,
        function()
            HyperMode.copyAll()
        end,
    })
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
    Pending.run({
        function()
            HyperMode.alfredClipboard()
        end,
        function()
            HyperMode.paste()
        end,
        function()
            triggerAlfredWorkflow('paste:strip', 'com.fuelingtheweb.commands')
        end,
    })
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
    spoon.TabMode.previous()
end

function HyperMode.k()
    spoon.TabMode.next()
end

function HyperMode.l()
    HyperMode.nextPage()
end

function HyperMode.semicolon()
    HyperMode.enableScrolling()
end

function HyperMode.quote()
    HyperMode.jumpTo()
end

function HyperMode.return_or_enter()
    fastKeyStroke('caps_lock')
end

function HyperMode.n()
    HyperMode.new()
end

function HyperMode.comma()
    -- Alfred
    fastKeyStroke({'alt'}, 'z')
end

function HyperMode.period()
    Artisan.start()
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

function HyperMode.copyAll()
    fastKeyStroke({'cmd'}, 'a')
    fastKeyStroke({'cmd'}, 'c')

    if inCodeEditor() then
        fastKeyStroke('escape')
        fastKeyStroke('g')
        fastKeyStroke('g')
    else
        fastKeyStroke('right')
    end
end

function HyperMode.open()
    if appIncludes({notion, atom, sublime, sublimeMerge, tableplus, invoker}) then
        fastKeyStroke({'cmd'}, 'p')

        if inCodeEditor() then
            TextManipulation.disableVim()
        end
    elseif appIs(discord) then
        fastKeyStroke({'cmd'}, 'k')
    elseif appIs(spotify) then
        triggerAlfredWorkflow('spot_mini', 'com.vdesabou.spotify.mini.player')
    elseif appIs(chrome) then
        fastKeyStroke({'shift'}, 'o')
    else
        fastKeyStroke({'cmd'}, 'o')
    end
end

function HyperMode.new()
    if appIs(atom) then
        TextManipulation.disableVim()
        fastKeyStroke({'alt', 'cmd'}, 'o')
    elseif appIs(sublime) then
        TextManipulation.disableVim()
        fastKeyStroke({'alt', 'cmd'}, 'n')
    else
        fastKeyStroke({'shift', 'cmd'}, 'n')
    end
end

function HyperMode.copyTextArea()
    if appIs(notion) then
        fastKeyStroke({'cmd'}, 'a')
        fastKeyStroke({'cmd'}, 'c')
        fastKeyStroke('right')
    else
        fastKeyStroke({'shift', 'cmd'}, 'up')
        fastKeyStroke({'cmd'}, 'c')
        fastKeyStroke('right')
    end
end

function HyperMode.commandPalette()
    if appIncludes({atom, sublime, sublimeMerge}) then
        fastKeyStroke({'shift', 'cmd'}, 'p')

        if inCodeEditor() then
            TextManipulation.disableVim()
        end
    else
        triggerAlfredWorkflow('search', 'com.tedwise.menubarsearch')
    end
end

function HyperMode.previousPage()
    if appIs(spotify) then
        fastKeyStroke({'alt', 'cmd'}, 'left')
    elseif appIs(discord) then
        fastKeyStroke({'cmd'}, 'k')
        fastKeyStroke('return')
    elseif appIs(atom) then
         -- Atom: Cursor History: Previous
        fastKeyStroke({'shift', 'alt'}, 'i')
    elseif appIs(sublime) then
        fastKeyStroke({'ctrl'}, '-')
    elseif appIs(iterm) then
        typeAndEnter('cdp')
    else
        fastKeyStroke({'cmd'}, '[')
    end
end

function HyperMode.nextPage()
    if appIs(spotify) then
        fastKeyStroke({'alt', 'cmd'}, 'right')
    elseif appIs(iterm) then
        -- Autocomplete to the end of the line
        fastKeyStroke({'cmd'}, 'l')
    elseif appIs(atom) then
         -- Atom: Cursor History: Next
        fastKeyStroke({'ctrl'}, 'o')
    elseif appIs(sublime) then
        fastKeyStroke({'ctrl', 'shift'}, '-')
    else
        fastKeyStroke({'cmd'}, ']')
    end
end

function HyperMode.jumpTo()
    if appIs(atom) then
        fastKeyStroke({'shift'}, 'return')
    elseif appIs(sublime) then
        fastKeyStroke({'shift', 'cmd'}, '.')
    else
        fastKeyStroke({'ctrl'}, 'space')
    end
end

function HyperMode.enableScrolling()
    -- Vimac: Enable Scroll
    fastKeyStroke({'ctrl', 'alt', 'cmd'}, 's')
end

function HyperMode.paste()
    fastKeyStroke({'cmd'}, 'v')

    if titleContains('Slack | ') then
        fastKeyStroke({'shift', 'cmd'}, 'f')
    end
end

function HyperMode.alfredClipboard()
    fastKeyStroke({'alt'}, 'c')
end

return HyperMode
