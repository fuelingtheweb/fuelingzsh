local CommandMode = {}
CommandMode.__index = CommandMode

CommandMode.lookup = {
    tab = 'shiftTab',
    q = 'quit',
    w = 'closeWindow',
    -- w = {'closeWindow', 'closeAllWindows'},
    e = {'edit', 'finishEdit'},
    r = 'reload',
    -- r = {'reload', 'reloadSecondary'},
    t = nil,
    caps_lock = 'alfredCommands',
    a = 'selectAll',
    s = 'save',
    -- s = {'save', 'saveAndReload'},
    d = 'done',
    f = 'find',
    g = 'searchGoogle',
    -- g = 'atomGitPalette',
    left_shift = nil,
    z = 'searchAmazon',
    x = 'cancelOrDelete',
    c = 'searchConflicts',
    v = 'duplicateLine',
    b = nil,
    spacebar = nil,
}

function CommandMode.searchGoogle()
    spoon.SearchMode.google()
end

function CommandMode.searchAmazon()
    spoon.SearchMode.amazon()
end

function CommandMode.shiftTab()
    fastKeyStroke({'shift'}, 'tab')
end

function CommandMode.quit()
    fastKeyStroke({'cmd'}, 'q')
end

function CommandMode.alfredCommands()
    triggerAlfredWorkflow('commands', 'com.fuelingtheweb.commands')
end

function CommandMode.selectAll()
    fastKeyStroke({'cmd'}, 'a')
end

function CommandMode.atomGitPalette()
    fastKeyStroke({'shift', 'cmd'}, 'h')
end

function CommandMode.duplicateLine()
    if inCodeEditor() then
        fastKeyStroke({'shift', 'cmd'}, 'd')
    elseif appIs(finder) then
        fastKeyStroke({'cmd'}, 'd')
    end
end

function CommandMode.reload()
    if appIs(atom) then
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

function CommandMode.closeWindow()
    closeWindow()
end

function CommandMode.find()
    if inCodeEditor() then
        fastKeyStroke({'shift', 'cmd'}, 'f')
        TextManipulation.disableVim()
    else
        fastKeyStroke({'cmd'}, 'f')
    end
end

function CommandMode.edit()
    -- Edit with
    fastKeyStroke({'shift', 'cmd'}, 'e')
end

function CommandMode.finishEdit()
    -- Edit with: Done
    fastKeyStroke({'shift', 'ctrl', 'alt', 'cmd'}, 'd')
end

function CommandMode.done()
    if appIs(sublime) then
        -- Plain Tasks: Complete
        fastKeyStroke({'ctrl', 'alt', 'cmd'}, 'd')
    elseif appIs(transmit) then
        -- Disconnect from server
        fastKeyStroke({'cmd'}, 'e')
    else
        fastKeyStroke({'cmd'}, 'return')
    end
end

function CommandMode.save()
    if appIs(chrome) then
        -- Save to Raindrop
        fastKeyStroke({'shift', 'cmd'}, 's')
    elseif appIs(iterm) then
        -- Save from Vim
        fastKeyStroke({'shift'}, ';')
        fastKeyStroke('x')
        fastKeyStroke('return')
    else
        fastKeyStroke({'cmd'}, 's')
    end
end

function CommandMode.cancelOrDelete()
    text = getSelectedText()
    if appIs(sublime) and titleContains('.todo') then
        fastKeyStroke({'ctrl'}, 'c')
    elseif appIncludes({atom, sublime}) then
        fastKeyStroke({'shift', 'cmd'}, 'delete')
    elseif appIs(finder) and text == 'finderFileSelected' then
        fastKeyStroke({'cmd'}, 'delete')
    elseif appIs(transmit) then
        fastKeyStroke({'cmd'}, 'delete')
    elseif text then
        fastKeyStroke('delete')
    elseif appIs(chrome) and stringContains('Fueling the Web Mail', currentTitle()) then
        fastKeyStroke({'shift'}, '3')
    elseif appIs(iterm) then
        fastKeyStroke({'ctrl'}, 'c')
    else
        fastKeyStroke('delete')
    end
end

return CommandMode
