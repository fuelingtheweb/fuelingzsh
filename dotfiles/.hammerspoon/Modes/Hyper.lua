local Hyper = {}
Hyper.__index = Hyper

Hyper.lookup = {
    y = 'copy',
    u = spoon.Search.tabs,
    i = spoon.Search.symbol,
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
    comma = ks.undo,
    period = ks.redo,
    slash = 'cheatsheets',
    -- slash = 'startArtisan',
    right_shift = nil,
    spacebar = 'forceEscape'
}

function Hyper.copy()
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
        md.Yank.relativeFilePath()
    end
end

-- Modal.add({
--     key = 'Hyper:open',
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
--         ks.type(item.extension)
--         for i = 1, item.extension:len() do
--             ks.left()
--         end
--         Modal.exit()
--     end,
-- })

function Hyper.open()
    -- handleApp({
    --     {{atom, sublime}, function()
    --         ks.cmd('p')
    --         TextManipulation.disableVim()
    --     end},
    --     {{notion, sublimeMerge, tableplus, invoker}, function()
    --         ks.cmd('p')
    --     end},
    --     {{discord, slack}, _(ks.fire, {'cmd'}, 'k')},
    --     {spotify, _(triggerAlfredWorkflow, 'spot_mini', 'com.vdesabou.spotify.mini.player')},
    --     {chrome, _(ks.fire, {'shift'}, 'o')},
    --     {'fallback', _(ks.fire, {'cmd'}, 'o')},
    -- })

    if appIncludes({
        notion, atom, vscode, sublime, sublimeMerge, tableplus, invoker
    }) then
        ks.cmd('p')

        if inCodeEditor() then
            TextManipulation.disableVim()
            -- Modal.enter('Hyper:open')
        end
    elseif appIncludes({discord, slack}) then
        ks.cmd('k')
    elseif appIs(spotify) then
        triggerAlfredWorkflow('spot_mini', 'com.vdesabou.spotify.mini.player')
    elseif appIs(chrome) then
        if urlContains('github.com') then
            ks.cmd('k')
        else
            ks.shift('o')
        end
    elseif appIs(iterm) then
        ks.type('cd ')
    else
        ks.cmd('o')
    end
end

function Hyper.new()
    if appIs(atom) then
        TextManipulation.disableVim()
        ks.altCmd('o')
    elseif appIs(sublime) then
        TextManipulation.disableVim()
        ks.altCmd('n')
    elseif appIs(vscode) then
        TextManipulation.disableVim()
        ks.altCmd('n')
    else
        ks.shiftCmd('n')
    end
end

function Hyper.commandPalette()
    if appIncludes({atom, vscode, sublime, sublimeMerge}) then
        ks.shiftCmd('p')

        if inCodeEditor() then TextManipulation.disableVim() end
    else
        triggerAlfredWorkflow('search', 'com.tedwise.menubarsearch')
    end
end

function Hyper.previousPage()
    if appIs(spotify) then
        ks.altCmd('left')
    elseif appIs(discord) then
        ks.cmd('k').enter()
    elseif appIs(atom) then
        -- Atom: Cursor History: Previous
        ks.shiftAlt('i')
    elseif appIs(sublime) then
        ks.ctrl('-')
    elseif appIs(iterm) then
        ks.type('cdp').enter()
    else
        ks.cmd('[')
    end
end

function Hyper.previousTab() md.Tab.previous() end

function Hyper.nextTab() md.Tab.next() end

function Hyper.nextPage()
    if appIs(spotify) then
        ks.altCmd('right')
    elseif appIs(iterm) then
        -- Autocomplete to the end of the line
        ks.super(';')
    elseif appIs(atom) then
        -- Atom: Cursor History: Next
        ks.ctrl('o')
    elseif appIs(sublime) then
        ks.shiftCtrl('-')
    else
        ks.cmd(']')
    end
end

function Hyper.alfredClipboard() ks.alt('c') end

function Hyper.paste()
    ks.paste()

    if titleContains('Slack | ') then ks.shiftCmd('f') end
end

function Hyper.pasteStrip()
    triggerAlfredWorkflow('paste:strip', 'com.fuelingtheweb.commands')
end

function Hyper.capsLock() ks.key('caps_lock') end

function Hyper.alfred() ks.alt('z') end

function Hyper.startArtisan() Artisan.start() end

function Hyper.forceEscape()
    md.Test.hideOutput()
    ks.escape().escape()
end

function Hyper.nextWindow() md.WindowManager.next() end

function Hyper.nextWindowInCurrentApp() md.WindowManager.nextInCurrentApp() end

function Hyper.cheatsheets() Modal.enter('Cheatsheets') end

return Hyper
