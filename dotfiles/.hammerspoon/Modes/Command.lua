local Command = {}
Command.__index = Command

Modal.load('Scrolling')

Command.lastApp = nil

Command.lookup = {
    tab = 'shiftTab',
    q = nil,
    w = cm.Window.enableScrolling,
    e = 'edit',
    r = 'reload',
    t = 'newTask',
    caps_lock = fn.Alfred.commands,
    a = fn.Alfred.actionFile,
    s = 'save',
    d = 'duplicate',
    f = 'finish',
    g = cm.Window.jumpTo,
    left_shift = nil,
    z = nil,
    x = 'cancelOrDelete',
    c = 'renameFile',
    v = 'duplicateLine',
    b = nil,
    spacebar = 'startTask',
}

function Command.shiftTab()
    ks.shift('tab')
end

function Command.duplicateLine()
    if is.codeEditor() then
        ks.shiftCmd('d')
    elseif is.googleSheet() then
        ks.shift('space').shift('space').slow().copy().left()
        md.Vi.moveToFirstCharacterOfLine()
        md.Make.lineAfter()
        ks.escape().slow().paste().left()
        md.Vi.moveToFirstCharacterOfLine()
    else
        md.Yank.line()
        ks.enter().paste()
    end
end

function Command.duplicate()
    local text = str.selected()

    if text then
        if is.codeEditor() then
            ks.super('d')
        else
            ks.right().type(text)
        end
    elseif is.finder() then
        ks.cmd('d')
    elseif is.chrome() then
        -- Vimium
        ks.escape().type('yt')
    elseif is.codeEditor() then
        ks.shiftAltCmd('d')
        TextManipulation.disableVim()
    end
end

function Command.reload()
    if is.vscode() then
        ks.shiftAltCmd('r')
    elseif is.In(postman) then
        ks.cmd('return')
    elseif is.In(tinkerwell) then
        ks.ctrl('l')
        ks.refresh()
    elseif is.terminal() then
        -- Run last command
        ks.up().enter()
    else
        ks.refresh()
    end
end

function Command.edit()
    Command.lastApp = hs.application.frontmostApplication()

    if is.vscode() then
        local site = ProjectManager.current()

        fn.misc.executeFromFuelingZsh('tinkerwell "' .. site.attributes.path .. '"')

        return
    end

    if is.gmail() then
        md.Yank.toTopOfPage()
    else
        md.Yank.all()
    end

    fn.Code.new()

    hs.timer.doAfter(0.5, function()
        ks.paste()
        md.Vi.moveToTopOfPage()
        ks.escape()
    end)
end

function Command.finish()
    if is.vscode() then
        if is.todo() or is.markdown() then
            ks.alt('d').slow().save()
        elseif fn.window.titleContains('.git/COMMIT_EDITMSG') or fn.window.titleContains('.git/MERGE_MSG') then
            ks.slow().save().slow().close()
            -- hs.application.launchOrFocusByBundleID(warp)
        elseif fn.window.titleContains('Untitled-') then
            md.Yank.all()

            hs.timer.doAfter(0.2, function()
                ks.super('w')
                Command.lastApp:activate()

                hs.timer.doAfter(0.2, function()
                    Command.lastApp = nil
                    md.Paste.all()
                    ks.delete()

                    if is.In(slack) then
                        ks.shiftCmd('f')
                    end
                end)
            end)
        end
    elseif is.In(transmit) then
        -- Disconnect from server
        ks.cmd('e')
    elseif is.In(tinkerwell) then
        ks.cmd('r')
    elseif is.sublimeMerge() then
        ks.enter()
    elseif is.googleSheet() then
        ks.enter().up()
    elseif is.terminal() then
        if fn.window.titleContains('git:checkout') or fn.window.titleContains('git:branch.delete') then
            ks.escape()
        elseif fn.window.titleContains('git:') or fn.window.titleContains('. git ') then
            ks.key('q')
        else
            ks.ctrl('c')
        end
    elseif is.chat() then
        ks.enter()
    else
        ks.cmd('return')
    end
end

function Command.save()
    if is.chrome() then
        -- Save to Reader
        ks.shiftCmd('s')
    elseif is.In(sigma) then
        -- Save to Reader
        ks.key('e').key('1')
    elseif is.terminal() then
        -- Save from Vim
        ks.shift(';').key('x').enter()
    elseif is.In(youtubeMusic) then
        ks.shift('=')
    else
        ks.save()

        if is.codeEditor() then
            ks.escape()
        end
    end
end

function Command.cancelOrDelete()
    local text = str.selected()

    if is.In(anybox) then
        ks.cmd('delete')
    elseif text then
        ks.delete()
    elseif is.vscode() and is.todo() then
        ks.alt('c')
    elseif is.codeEditor() then
        ks.shiftCmd('delete')
    elseif is.In(transmit, finder) then
        ks.cmd('delete')
    elseif is.gmail() then
        ks.shift('3')
    elseif is.terminal() then
        ks.ctrl('c')
    elseif is.In(youtubeMusic) then
        ks.shift('-')
    else
        ks.delete()
    end
end

function Command.startTask()
    ks.alt('s').slow().save()
end

function Command.newTask()
    if is.markdown() then
        ks.alt('return')
    else
        ks.cmd('return')
    end
end

function Command.renameFile()
    if is.vscode() then
        TextManipulation.disableVim()
        fn.Code.run('File Utils: Rename')
        hs.timer.doAfter(0.4, TextManipulation.disableVim)
    end
end

return Command
