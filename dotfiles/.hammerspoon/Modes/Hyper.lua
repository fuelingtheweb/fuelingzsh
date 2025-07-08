local Hyper = {}
Hyper.__index = Hyper

Hyper.lookup = {
    y = 'copy',
    u = 'u',
    i = 'i',
    o = 'o',
    p = fn.Alfred.clipboard,
    open_bracket = 'commandPalette',
    close_bracket = nil,
    h = 'previousPage',
    j = 'j',
    k = 'k',
    l = 'l',
    semicolon = cm.Window.nextInCurrentApp,
    quote = 'quote',
    return_or_enter = function() hs.hid.capslock.set(true) end,
    -- Change new to be a command shortcut
    n = 'sideNotes',
    m = 'm',
    comma = 'comma',
    period = 'period',
    slash = 'cheatsheets',
    right_shift = nil,
    spacebar = 'forceEscape',
}

function Hyper.copy()
    fn.clipboard.clear()
    md.Yank.normal()
    local text = fn.clipboard.get()

    if is.In(spotify) then
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
        fn.clipboard.set(text)
    elseif is.chrome() then
        fn.Chrome.copyUrl()
    elseif is.brave() then
        fn.Brave.copyUrl()
    elseif is.arc() then
        fn.Arc.copyUrl()
    elseif is.In(sigma) then
        ks.cmd('l')
    elseif is.codeEditor() then
        md.Yank.relativeFilePath()
    end
end

function Hyper.open()
    if is.In(vscode, sublimeMerge, tableplus, invoker) then
        ks.cmd('p')

        if is.codeEditor() then
            TextManipulation.disableVim()
        end
    elseif is.In(arc) then
        fn.open('raycast://extensions/the-browser-company/arc/search-spaces')
        -- ks.cmd('t')
    elseif is.In(mail) then
        ks.shiftCmd('o')
    elseif is.In(anybox) then
        ks.cmd('p')
    elseif is.In(discord, slack) then
        ks.cmd('k')
    elseif is.In(spotify) then
        fn.Alfred.run('spot_mini', 'com.vdesabou.spotify.mini.player')
    elseif is.arc() then
        if fn.Arc.urlContains('github.com')
            or fn.Arc.urlContains('tailwindcss.com/docs')
            or fn.Arc.urlContains('laravel.com/docs')
        then
            ks.cmd('k')
        elseif fn.Arc.urlContains('laravel-livewire.com/docs') then
            ks.key('/')
        else
            ks.cmd('l')
        end
    elseif is.terminal() then
        ks.type('wd ')
    else
        ks.cmd('o')
    end
end

function Hyper.new()
    if is.vscode() then
        TextManipulation.disableVim()
        ks.altCmd('n')
    else
        ks.shiftCmd('n')
    end
end

function Hyper.commandPalette()
    if is.In(vscode, sublimeMerge) then
        ks.shiftCmd('p')

        if is.codeEditor() then
            TextManipulation.disableVim()
        end
    elseif is.In(warp, obsidian, gitfox) then
        ks.cmd('p')
    elseif is.In(anybox) then
        ks.cmd('k')
    elseif is.In(arc) then
        ks.cmd('t')
    else
        fn.Alfred.run('search', 'com.tedwise.menubarsearch')
    end
end

function Hyper.previousPage()
    if is.In(spotify) then
        ks.altCmd('left')
    elseif is.In(discord) then
        ks.cmd('k').enter()
    elseif is.terminal() then
        ks.typeAndEnter('cdp')
    elseif fn.Raycast.visible() then
        ks.key('escape')
    else
        ks.cmd('[')
    end
end

function Hyper.nextPage()
    if is.In(spotify) then
        ks.altCmd('right')
    elseif is.iterm() then
        -- Autocomplete to the end of the line
        hs.timer.doAfter(0.1, function()
            ks.super(';')
        end)
    elseif is.warp() then
        -- Autocomplete to the end of the line
        ks.ctrl('f')
    else
        ks.cmd(']')
    end
end

function Hyper.paste()
    ks.paste()

    if is.In(slack) or fn.window.titleContains('Slack | ') then
        ks.shiftCmd('f')
    end
end

function Hyper.pasteStrip()
    fn.Alfred.run('paste:strip', 'com.fuelingtheweb.commands')
end

function Hyper.forceEscape()
    if is.In(warp) then
        ks.ctrl('r')
    elseif fn.Raycast.visible() then
        ks.close()
    elseif cm.Window.scrolling then
        ks.escape()

        hs.timer.doAfter(0.2, function()
            md.Test.hideOutput()
            ks.escape().escape()
        end)
    else
        md.Test.hideOutput()
        ks.escape().escape()
    end
end

function Hyper.cheatsheets()
    Modal.enter('Cheatsheets')
end

function Hyper.undo()
    -- if is.vimMode() then
    --     ks.escape().key('u')
    -- else
    ks.undo()
    -- end
end

function Hyper.redo()
    -- if is.vimMode() then
    --     ks.escape().ctrl('r')
    -- else
    ks.redo()
    -- end
end

function Hyper.u()
    if is.quickFind() then
        ks.cmd('1')
    else
        fn.Raycast.open()
    end
end

function Hyper.i()
    if is.quickFind() then
        ks.cmd('2')
    -- elseif fn.SideNotes.isVisible() then
    --     fn.SideNotes.new()
    elseif is.terminal() then
        ks.type('cd ')
    elseif is.arc() then
        fn.Alfred.run('open tab', 'com.hellovietduc.alfred.arc-control')
    else
        cm.Search.symbol()
    end
end

function Hyper.o()
    if is.quickFind() then
        ks.cmd('3')
    -- elseif fn.SideNotes.isVisible() then
    --     fn.SideNotes.search()
    else
        Hyper.open()
    end
end

function Hyper.j()
    if is.quickFind() then
        ks.cmd('4')
    -- elseif fn.SideNotes.isVisible() then
    --     fn.SideNotes.next()
    elseif is.In(dash) then
        ks.alt('down')
    else
        cm.Tab.previous()
    end
end

function Hyper.k()
    if is.quickFind() then
        ks.cmd('5')
    -- elseif fn.SideNotes.isVisible() then
    --     fn.SideNotes.previous()
    elseif is.In(dash) then
        ks.alt('up')
    else
        cm.Tab.next()
    end
end

function Hyper.l()
    if is.quickFind() then
        ks.cmd('6')
    else
        Hyper.nextPage()
    end
end

function Hyper.m()
    if is.quickFind() then
        ks.cmd('7')
    -- elseif fn.SideNotes.isVisible() then
    --     fn.SideNotes.delete()
    else
        cm.Window.destroy()
    end
end

function Hyper.comma()
    if is.quickFind() then
        ks.cmd('8')
    else
        Hyper.undo()
    end
end

function Hyper.period()
    if is.quickFind() then
        ks.cmd('9')
    else
        Hyper.redo()
    end
end

function Hyper.sideNotes()
    if fn.Raycast.visible() then
        ks.cmd('escape')
    else
        fn.SideNotes.toggle()
    end
end

function Hyper.quote()
    if fn.Raycast.visible() then
        ks.cmd('k')
    else
        cm.Window.next()
    end
end

return Hyper
