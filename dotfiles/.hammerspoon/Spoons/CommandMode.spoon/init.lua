local CommandMode = {}
CommandMode.__index = CommandMode

function CommandMode.tab()
    -- Shift tab
    hs.eventtap.keyStroke({'shift'}, 'tab')
end

function CommandMode.q()
    -- Quit
    hs.eventtap.keyStroke({'cmd'}, 'q')
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
    hs.eventtap.keyStroke({'cmd'}, 'a')
end

hs.loadSpoon('ModalMgr')
SaveModal = {}
SaveModal.active = false
SaveModal.modalKey = 'SaveModal'

spoon.ModalMgr:new(SaveModal.modalKey)
SaveModal.modal = spoon.ModalMgr.modal_list[SaveModal.modalKey]

SaveModal.modal:bind('', 'escape', nil, function()
    spoon.ModalMgr:deactivate({SaveModal.modalKey})
    hs.eventtap.keyStroke({}, 'escape', 0)
end)
SaveModal.modal.entered = function()
    SaveModal.active = true
end
SaveModal.modal.exited = function()
    SaveModal.active = false
end

SaveModal.actions = {
    {key = 'j', method = 'saveAndGoToPreviousTab'},
    {key = 'k', method = 'saveAndGoToNextTab'},
    {key = ';', method = 'saveAndGoToNextWindow'},
}

function CommandMode.saveAndGoToPreviousTab()
    CommandMode.save()
    HyperMode.previousTab()
end

function CommandMode.saveAndGoToNextTab()
    CommandMode.save()
    HyperMode.nextTab()
end

function CommandMode.saveAndGoToNextWindow()
    CommandMode.save()
    WindowManager.next()
end

each(SaveModal.actions, function(item)
    SaveModal.modal:bind('', item.key, nil, function()
        CommandMode[item.method]()
        spoon.ModalMgr:deactivate({SaveModal.modalKey})
    end)
end)

function SaveModal.exit()
    spoon.ModalMgr:deactivateAll()
end

function SaveModal.enter()
    spoon.ModalMgr:deactivateAll()
    spoon.ModalMgr:activate({SaveModal.modalKey}, '#FFFFFF', false)
end

function CommandMode.s()
    SaveModal.enter()

    -- Save or Save and reload Chrome
    Pending.run({
        function()
            SaveModal.exit()
            CommandMode.save()
        end,
        function()
            SaveModal.exit()
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
    hs.eventtap.keyStroke({'shift', 'cmd'}, 'h')
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
    hs.eventtap.keyStroke({}, 'escape', 0)
    hs.eventtap.keyStroke({}, 'y', 0)
    hs.eventtap.keyStroke({}, 'y', 0)
    hs.eventtap.keyStroke({}, 'p', 0)
end

function CommandMode.b()
end

function CommandMode.spacebar()
end

function CommandMode.reload()
    if appIs(atom) then
        hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 'r', 0)
    elseif appIs(postman) then
        hs.eventtap.keyStroke({'cmd'}, 'return', 0)
    elseif appIs(iterm) then
        -- Run last command
        hs.eventtap.keyStroke({}, 'up', 0)
        hs.eventtap.keyStroke({}, 'return', 0)
    else
        hs.eventtap.keyStroke({'cmd'}, 'r', 0)
    end
end

function CommandMode.reloadSecondary()
    if appIs(chrome) then
        -- Hard refresh
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'r', 0)
    elseif appIs(iterm) then
        -- Reload running command
        hs.eventtap.keyStroke({'ctrl'}, 'c', 0)
        hs.eventtap.keyStroke({}, 'up', 0)
        hs.eventtap.keyStroke({}, 'return', 0)
    end
end

function CommandMode.closeWindow()
    closeWindow()
end

function CommandMode.find()
    if inCodeEditor() then
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'f')
        TextManipulation.disableVim()
    else
        hs.eventtap.keyStroke({'cmd'}, 'f')
    end
end

function CommandMode.edit()
    -- Edit with
    hs.eventtap.keyStroke({'shift', 'cmd'}, 'e')
end

function CommandMode.finishEdit()
    -- Edit with: Done
    hs.eventtap.keyStroke({'shift', 'ctrl', 'alt', 'cmd'}, 'd')
end

function CommandMode.done()
    if appIs(sublime) then
        -- Plain Tasks: Complete
        hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 'd')
    elseif appIs(transmit) then
        -- Disconnect from server
        hs.eventtap.keyStroke({'cmd'}, 'e')
    else
        hs.eventtap.keyStroke({'cmd'}, 'return')
    end
end

function CommandMode.save()
    if appIs(chrome) then
        -- Save to Raindrop
        hs.eventtap.keyStroke({'shift', 'cmd'}, 's')
    elseif appIs(iterm) then
        -- Save from Vim
        hs.eventtap.keyStroke({'shift'}, ';')
        hs.eventtap.keyStroke({}, 'x')
        hs.eventtap.keyStroke({}, 'return')
    else
        hs.eventtap.keyStroke({'cmd'}, 's')
    end
end

function CommandMode.saveAndReload()
    hs.eventtap.keyStroke({}, 'escape')
    hs.eventtap.keyStroke({'cmd'}, 'S')
    hs.application.get(apps['chrome']):activate()
    hs.eventtap.keyStroke({'cmd'}, 'R')
end

function CommandMode.cancelOrDelete()
    text = getSelectedText()
    if appIncludes({atom, sublime}) then
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'delete')
    elseif appIs(finder) and text == 'finderFileSelected' then
        hs.eventtap.keyStroke({'cmd'}, 'delete')
    elseif appIs(transmit) then
        hs.eventtap.keyStroke({'cmd'}, 'delete')
    elseif text then
        hs.eventtap.keyStroke({}, 'delete')
    elseif appIs(chrome) and stringContains('Fueling the Web Mail', currentTitle()) then
        hs.eventtap.keyStroke({'shift'}, '3')
    elseif appIs(iterm) then
        hs.eventtap.keyStroke({'ctrl'}, 'C')
    else
        hs.eventtap.keyStroke({}, 'delete')
    end
end

function CommandMode.closeAllWindows()
    hs.eventtap.keyStroke({'shift', 'cmd'}, 'W')
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
