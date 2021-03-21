local CommandMode = {}
CommandMode.__index = CommandMode

function CommandMode.tab()
    -- Shift tab
    fastKeyStroke({'shift'}, 'tab')
end

function CommandMode.q()
    -- Quit
    fastKeyStroke({'cmd'}, 'q')
end

function CommandMode.w()
    Pending.run({
        CommandMode.closeWindow,
        CommandMode.closeAllWindows,
    })
end

function CommandMode.e()
    -- Edit With
    Pending.run({
        CommandMode.edit,
        CommandMode.finishEdit,
    })
end

function CommandMode.r()
    -- Reload or Chrome hard refresh
    Pending.run({
        CommandMode.reload,
        CommandMode.reloadSecondary,
    })
end

function CommandMode.t()
end

function CommandMode.caps_lock()
    triggerAlfredWorkflow('commands', 'com.fuelingtheweb.commands')
end

function CommandMode.a()
    -- Select All
    fastKeyStroke({'cmd'}, 'a')
end

Modal.add({
    key = 'CommandMode:save',
    shortcuts = {
        ['j'] = function()
            spoon.HyperMode.previousTab()
        end,
        ['k'] = function()
            spoon.HyperMode.nextTab()
        end,
        [';'] = function()
            spoon.WindowManager.next()
        end,
    },
})

function CommandMode.s()
    -- Modal.enter('CommandMode:save', 2)

    -- Save or Save and reload Chrome
    Pending.run({
        function()
            CommandMode.save()
        end,
        function()
            -- Modal.exit()
            CommandMode.saveAndReload()
        end,
    })
end

function CommandMode.d()
    CommandMode.done()
end

function CommandMode.f()
    CommandMode.find()
end

function CommandMode.g()
    -- Atom: Toggle Git Palette
    fastKeyStroke({'shift', 'cmd'}, 'h')
end

function CommandMode.left_shift()
end

function CommandMode.z()
    -- Alfred: Sleep
    triggerAlfredSearch('sleep')
end

function CommandMode.x()
    CommandMode.cancelOrDelete()
end

function CommandMode.c()
end

function CommandMode.v()
    -- Duplicate line
    fastKeyStroke('escape')
    fastKeyStroke('y')
    fastKeyStroke('y')
    fastKeyStroke('p')
end

function CommandMode.b()
end

function CommandMode.spacebar()
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

function CommandMode.reloadSecondary()
    if appIs(chrome) then
        -- Hard refresh
        fastKeyStroke({'shift', 'cmd'}, 'r')
    elseif appIs(iterm) then
        -- Reload running command
        fastKeyStroke({'ctrl'}, 'c')
        fastKeyStroke('up')
        fastKeyStroke('return')
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

function CommandMode.saveAndReload()
    fastKeyStroke('escape')
    keyStroke({'cmd'}, 's')
    hs.application.get(apps['chrome']):activate()
    keyStroke({'cmd'}, 'r')
end

function CommandMode.cancelOrDelete()
    text = getSelectedText()
    if appIncludes({atom, sublime}) then
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

function CommandMode.closeAllWindows()
    fastKeyStroke({'shift', 'cmd'}, 'w')
    if appIs(chrome) then
        hs.timer.doAfter(1, function()
            app = hs.application.frontmostApplication()
            if next(app:visibleWindows()) == nil then
                app:hide()
            end
        end)
    end
end

return CommandMode
