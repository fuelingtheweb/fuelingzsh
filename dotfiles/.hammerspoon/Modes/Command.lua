local Command = {}
Command.__index = Command

Command.lookup = {
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

function Command.searchGoogle()
    spoon.Search.google()
end

function Command.searchAmazon()
    spoon.Search.amazon()
end

function Command.searchConflicts()
    spoon.Search.mergeConflicts()
end

function Command.shiftTab()
    fastKeyStroke({'shift'}, 'tab')
end

function Command.quit()
    fastKeyStroke({'cmd'}, 'q')
end

function Command.alfredCommands()
    triggerAlfredWorkflow('commands', 'com.fuelingtheweb.commands')
end

function Command.selectAll()
    fastKeyStroke({'cmd'}, 'a')
end

function Command.atomGitPalette()
    fastKeyStroke({'shift', 'cmd'}, 'h')
end

function Command.duplicateLine()
    if inCodeEditor() then
        fastKeyStroke({'shift', 'cmd'}, 'd')
    elseif appIs(finder) then
        fastKeyStroke({'cmd'}, 'd')
    end
end

function Command.reload()
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

function Command.closeWindow()
    closeWindow()
end

function Command.find()
    if inCodeEditor() then
        fastKeyStroke({'shift', 'cmd'}, 'f')
        TextManipulation.disableVim()
    else
        fastKeyStroke({'cmd'}, 'f')
    end
end

function Command.edit()
    -- Edit with
    fastKeyStroke({'shift', 'cmd'}, 'e')
end

function Command.finishEdit()
    -- Edit with: Done
    fastKeyStroke({'shift', 'ctrl', 'alt', 'cmd'}, 'd')
end

function Command.done()
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
        fastKeyStroke({'cmd'}, 's')
    end
end

function Command.cancelOrDelete()
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

return Command
