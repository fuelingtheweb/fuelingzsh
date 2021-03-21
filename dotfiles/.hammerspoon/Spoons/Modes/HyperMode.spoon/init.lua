local HyperMode = {}
HyperMode.__index = HyperMode

HyperMode.lookup = {
    y = {'copy', 'copyAll'},
    u = 'copyTextArea',
    i = nil,
    o = 'open',
    p = {'alfredClipboard', 'paste', 'pasteStrip'},
    open_bracket = 'commandPalette',
    close_bracket = nil,
    h = 'previousPage',
    j = 'previousTab',
    k = 'nextTab',
    l = 'nextPage',
    semicolon = 'enableScrolling',
    quote = 'jumpTo',
    return_or_enter = 'capsLock',
    n = 'new',
    m = 'alfred',
    comma = nil,
    period = 'startArtisan',
    slash = nil,
    right_shift = nil,
    spacebar = nil,
}

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

function HyperMode.previousTab()
    spoon.TabMode.previous()
end

function HyperMode.nextTab()
    spoon.TabMode.next()
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

function HyperMode.alfredClipboard()
    fastKeyStroke({'alt'}, 'c')
end

function HyperMode.paste()
    fastKeyStroke({'cmd'}, 'v')

    if titleContains('Slack | ') then
        fastKeyStroke({'shift', 'cmd'}, 'f')
    end
end

function HyperMode.pasteStrip()
    triggerAlfredWorkflow('paste:strip', 'com.fuelingtheweb.commands')
end

function HyperMode.capsLock()
    fastKeyStroke('caps_lock')
end

function HyperMode.alfred()
    fastKeyStroke({'alt'}, 'z')
end

function HyperMode.startArtisan()
    Artisan.start()
end

return HyperMode
