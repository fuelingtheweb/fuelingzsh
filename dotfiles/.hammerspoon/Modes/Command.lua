local Command = {}
Command.__index = Command

Command.lookup = {
    tab = 'shiftTab',
    q = nil,
    w = nil,
    e = 'edit',
    r = 'reload',
    t = nil,
    caps_lock = 'alfredCommands',
    a = 'actionFileInAlfred',
    s = 'save',
    d = 'duplicate',
    f = 'finish',
    g = nil,
    -- g = 'atomGitPalette',
    left_shift = nil,
    z = nil,
    x = 'cancelOrDelete',
    c = nil,
    v = 'duplicateLine',
    b = nil,
    spacebar = nil
}

function Command.shiftTab() ks.shift('tab') end

function Command.alfredCommands()
    triggerAlfredWorkflow('commands', 'com.fuelingtheweb.commands')
end

function Command.atomGitPalette() ks.shiftCmd('h') end

function Command.duplicateLine() if inCodeEditor() then ks.shiftCmd('d') end end

function Command.duplicate()
    local text = getSelectedText()
    if text then
        if inCodeEditor() then
            ks.super('d')
        else
            ks.key('right')
            insertText(text)
        end
    elseif appIs(finder) then
        ks.cmd('d')
    elseif appIs(chrome) then
        -- Vimium
        ks.escape()
        insertText('yt')
    elseif inCodeEditor() then
        ks.shiftAltCmd('d')
        TextManipulation.disableVim()
    end
end

function Command.reload()
    if appIncludes({atom, vscode}) then
        ks.super('r')
    elseif appIs(postman) then
        ks.cmd('return')
    elseif appIs(iterm) then
        -- Run last command
        ks.key('up')
        ks.key('return')
    else
        ks.cmd('r')
    end
end

function Command.closeWindow() closeWindow() end

function Command.edit() triggerAlfredWorkflow('edit', 'com.sztoltz.editwith') end

function Command.finish()
    if appIs(sublime) then
        if titleContains('com%.sztoltz%.editwith') then
            triggerAlfredWorkflow('finish', 'com.sztoltz.editwith')
        else
            -- Plain Tasks: Complete
            ks.super('d')
        end
    elseif appIs(transmit) then
        -- Disconnect from server
        ks.cmd('e')
    else
        ks.cmd('return')
    end
end

function Command.save()
    if appIs(chrome) then
        -- Save to Raindrop
        ks.shiftCmd('s')
    elseif appIs(iterm) then
        -- Save from Vim
        ks.shift(';')
        ks.key('x')
        ks.key('return')
    else
        log.d('Saving with cmd+s...')
        ks.cmd('s')

        -- if inCodeEditor() then ks.escape() end
        if inCodeEditor() then ks.escape() end
    end
end

function Command.cancelOrDelete()
    text = getSelectedText()
    if text then
        ks.key('delete')
    elseif appIs(sublime) and titleContains('.todo') then
        ks.ctrl('c')
    elseif inCodeEditor() then
        ks.shiftCmd('delete')
    elseif appIncludes({transmit, finder}) then
        ks.cmd('delete')
    elseif appIs(chrome) and
        stringContains('Fueling the Web Mail', currentTitle()) then
        ks.shift('3')
    elseif appIs(iterm) then
        ks.ctrl('c')
    else
        ks.key('delete')
    end
end

function Command.actionFileInAlfred() ks.altCmd('\\') end

return Command
