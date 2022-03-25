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

function Command.shiftTab() fastKeyStroke({'shift'}, 'tab') end

function Command.alfredCommands()
    triggerAlfredWorkflow('commands', 'com.fuelingtheweb.commands')
end

function Command.atomGitPalette() fastKeyStroke({'shift', 'cmd'}, 'h') end

function Command.duplicateLine()
    if inCodeEditor() then fastKeyStroke({'shift', 'cmd'}, 'd') end
end

function Command.duplicate()
    local text = getSelectedText()
    if text then
        if inCodeEditor() then
            fastKeyStroke({'ctrl', 'alt', 'cmd'}, 'd')
        else
            fastKeyStroke('right')
            insertText(text)
        end
    elseif appIs(finder) then
        fastKeyStroke({'cmd'}, 'd')
    elseif appIs(chrome) then
        -- Vimium
        fastKeyStroke('escape')
        insertText('yt')
    elseif inCodeEditor() then
        fastKeyStroke({'shift', 'alt', 'cmd'}, 'd')
        TextManipulation.disableVim()
    end
end

function Command.reload()
    if appIncludes({atom, vscode}) then
        fastKeyStroke({'ctrl', 'alt', 'cmd'}, 'r')
    elseif appIs(postman) then
        fastKeyStroke({'cmd'}, 'return')
    elseif appIs(iterm) then
        -- Run last command
        fastKeyStroke('up')
        fastKeyStroke('return')
    else
        fastKeyStroke({'cmd'}, 'r')
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
            fastKeyStroke({'ctrl', 'alt', 'cmd'}, 'd')
        end
    elseif appIs(transmit) then
        -- Disconnect from server
        fastKeyStroke({'cmd'}, 'e')
    else
        fastKeyStroke({'cmd'}, 'return')
    end
end

function Command.save()
    if appIs(chrome) then
        -- Save to Raindrop
        fastKeyStroke({'shift', 'cmd'}, 's')
    elseif appIs(iterm) then
        -- Save from Vim
        fastKeyStroke({'shift'}, ';')
        fastKeyStroke('x')
        fastKeyStroke('return')
    else
        log.d('Saving with cmd+s...')
        fastKeyStroke({'cmd'}, 's')
    end
end

function Command.cancelOrDelete()
    text = getSelectedText()
    if text then
        fastKeyStroke('delete')
    elseif appIs(sublime) and titleContains('.todo') then
        fastKeyStroke({'ctrl'}, 'c')
    elseif inCodeEditor() then
        fastKeyStroke({'shift', 'cmd'}, 'delete')
    elseif appIncludes({transmit, finder}) then
        fastKeyStroke({'cmd'}, 'delete')
    elseif appIs(chrome) and
        stringContains('Fueling the Web Mail', currentTitle()) then
        fastKeyStroke({'shift'}, '3')
    elseif appIs(iterm) then
        fastKeyStroke({'ctrl'}, 'c')
    else
        fastKeyStroke('delete')
    end
end

function Command.actionFileInAlfred() fastKeyStroke({'alt', 'cmd'}, '\\') end

return Command
