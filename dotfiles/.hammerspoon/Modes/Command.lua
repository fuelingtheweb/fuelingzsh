local Command = {}
Command.__index = Command

Command.lookup = {
    tab = 'shiftTab',
    q = nil,
    w = cm.Window.enableScrolling,
    e = 'edit',
    r = 'reload',
    t = nil,
    caps_lock = fn.Alfred.commands,
    a = fn.Alfred.actionFile,
    s = 'save',
    d = 'duplicate',
    f = 'finish',
    g = cm.Window.jumpTo,
    -- g = 'atomGitPalette',
    left_shift = nil,
    z = nil,
    x = 'cancelOrDelete',
    c = nil,
    v = 'duplicateLine',
    b = nil,
    spacebar = nil,
}

function Command.shiftTab()
    ks.shift('tab')
end

function Command.atomGitPalette()
    ks.shiftCmd('h')
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
    local text = getSelectedText()

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
    if is.In(atom, vscode) then
        ks.super('r')
    elseif is.In(postman) then
        ks.cmd('return')
    elseif is.iterm() then
        -- Run last command
        ks.up().enter()
    else
        ks.refresh()
    end
end

function Command.edit()
    fn.Alfred.run('edit', 'com.sztoltz.editwith')
end

function Command.finish()
    if is.sublime() then
        if titleContains('com%.sztoltz%.editwith') then
            fn.Alfred.run('finish', 'com.sztoltz.editwith')
        else
            -- Plain Tasks: Complete
            ks.super('d')
        end
    elseif is.In(transmit) then
        -- Disconnect from server
        ks.cmd('e')
    elseif is.vscode() and (titleContains('.git/COMMIT_EDITMSG') or titleContains('.git/MERGE_MSG')) then
        ks.slow().save().slow().close()
        fn.iTerm.launch()
    elseif is.In(sublimeMerge) then
        ks.enter()
    elseif is.googleSheet() then
        ks.enter().up()
    else
        ks.cmd('return')
    end
end

function Command.save()
    if is.chrome() then
        -- Save to Raindrop
        ks.shiftCmd('s')
    elseif is.iterm() then
        -- Save from Vim
        ks.shift(';').key('x').enter()
    else
        ks.save()

        if is.codeEditor() then ks.escape() end
    end
end

function Command.cancelOrDelete()
    text = getSelectedText()

    if text then
        ks.delete()
    elseif is.sublime() and titleContains('.todo') then
        ks.ctrl('c')
    elseif is.codeEditor() then
        ks.shiftCmd('delete')
    elseif is.In(transmit, finder) then
        ks.cmd('delete')
    elseif is.chrome() and
        stringContains('Fueling the Web Mail', currentTitle()) then
        ks.shift('3')
    elseif is.iterm() then
        ks.ctrl('c')
    else
        ks.delete()
    end
end

return Command
