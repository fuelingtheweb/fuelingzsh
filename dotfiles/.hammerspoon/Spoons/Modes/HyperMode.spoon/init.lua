local HyperMode = {}
HyperMode.__index = HyperMode

HyperMode.lookup = {
    y = 'copy',
        u = 'searchTabs',
    i = 'searchSymbols',
    o = 'open',
    p = 'alfredClipboard',
    open_bracket = 'commandPalette',
        close_bracket = nil,
    h = 'previousPage',
    j = 'previousTab',
    k = 'nextTab',
    l = 'nextPage',
    semicolon = 'nextWindowInCurrentApp',
    quote = 'nextWindow',
    return_or_enter = 'capsLock',
    n = 'new',
        m = 'alfred',
    comma = 'undo',
    period = 'redo',
    slash = 'cheatsheets',
    -- slash = 'startArtisan',
        right_shift = nil,
    spacebar = 'forceEscape',
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
    elseif inCodeEditor() then
        spoon.YankMode.relativeFilePath()
    end
end

function HyperMode.searchSymbols()
    spoon.SearchMode.symbol()
end

function HyperMode.searchTabs()
    spoon.SearchMode.tabs()
end

-- Modal.add({
--     key = 'HyperMode:open',
--     title = 'Hyper: Open',
--     items = {
--         p = {extension = '.php'},
--         b = {extension = '.blade.php'},
--         j = {extension = '.js'},
--         l = {extension = '.lua'},
--         y = {extension = '.py'},
--         v = {extension = '.vue'},
--         c = {extension = '.css'},
--         s = {extension = '.sass'},
--         t = {extension = 'Test.php'},
--     },
--     callback = function(item)
--         insertText(item.extension)
--         for i = 1, item.extension:len() do
--             fastKeyStroke('left')
--         end
--         Modal.exit()
--     end,
-- })

function HyperMode.open()
    -- handleApp({
    --     {{atom, sublime}, function()
    --         fastKeyStroke({'cmd'}, 'p')
    --         TextManipulation.disableVim()
    --     end},
    --     {{notion, sublimeMerge, tableplus, invoker}, function()
    --         fastKeyStroke({'cmd'}, 'p')
    --     end},
    --     {{discord, slack}, _(fastKeyStroke, {'cmd'}, 'k')},
    --     {spotify, _(triggerAlfredWorkflow, 'spot_mini', 'com.vdesabou.spotify.mini.player')},
    --     {chrome, _(fastKeyStroke, {'shift'}, 'o')},
    --     {'fallback', _(fastKeyStroke, {'cmd'}, 'o')},
    -- })

    if appIncludes({notion, atom, sublime, sublimeMerge, tableplus, invoker}) then
        fastKeyStroke({'cmd'}, 'p')

        if inCodeEditor() then
            TextManipulation.disableVim()
            -- Modal.enter('HyperMode:open')
        end
    elseif appIncludes({discord, slack}) then
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
        fastSuperKeyStroke(';')
    elseif appIs(atom) then
         -- Atom: Cursor History: Next
        fastKeyStroke({'ctrl'}, 'o')
    elseif appIs(sublime) then
        fastKeyStroke({'ctrl', 'shift'}, '-')
    else
        fastKeyStroke({'cmd'}, ']')
    end
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

function HyperMode.forceEscape()
    spoon.TestMode.hideOutput()
    -- keyStroke('escape')
    fastKeyStroke('escape')
    fastKeyStroke('escape')
    -- fastKeyStroke('escape')
end

function HyperMode.undo()
    fastKeyStroke({'cmd'}, 'z')
end

function HyperMode.redo()
    fastKeyStroke({'shift', 'cmd'}, 'z')
end

function HyperMode.nextWindow()
    spoon.WindowManager.next()
end

function HyperMode.nextWindowInCurrentApp()
    spoon.WindowManager.nextInCurrentApp()
end

function HyperMode.cheatsheets()
    Modal.enter('Cheatsheets')
end

function HyperMode.loadCheatsheets()
    dofile(hs.configdir .. '/Spoons/Modes/HyperMode.spoon/cheatsheets-modal.lua')
end

return HyperMode
