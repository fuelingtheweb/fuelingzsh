local TextManipulation = {}
TextManipulation.__index = TextManipulation
TextManipulation.spoonPath = '/Users/nathan/.hammerspoon/Spoons/TextManipulation.spoon'

hs.loadSpoon('ModalMgr')
TextManipulation.vimEnabled = true
TextManipulation.menuBar = hs.menubar.newWithPriority(hs.menubar.priorities['system']):setTitle(''):returnToMenuBar();
TextManipulation.modalKey = 'DisabledVimTextManipulation'

spoon.ModalMgr:new(TextManipulation.modalKey)
TextManipulation.modal = spoon.ModalMgr.modal_list[TextManipulation.modalKey]

TextManipulation.modal:bind('', 'escape', nil, function()
    spoon.ModalMgr:deactivate({TextManipulation.modalKey})
    hs.eventtap.keyStroke({}, 'escape', 0)
end)
TextManipulation.modal:bind('', 'return', nil, function()
    if inCodeEditor() then
        spoon.ModalMgr:deactivate({TextManipulation.modalKey})
        hs.eventtap.keyStroke({}, 'return', 0)
    end
end)
TextManipulation.modal.entered = function()
    TextManipulation.vimEnabled = false
    TextManipulation.menuBar:setTitle('Vim Text Manipulation Disabled')
end
TextManipulation.modal.exited = function()
    TextManipulation.vimEnabled = true
    TextManipulation.menuBar:setTitle('')
end

function TextManipulation.canManipulateWithVim()
    if not TextManipulation.vimEnabled or isAlfredVisible() then
        return false
    end

    if appIncludes({atom, sublime}) then
        return true
    end

    return false
    -- return vim.mode ~= 'insert'
end

function TextManipulation.disableVim()
    spoon.ModalMgr:deactivateAll()
    spoon.ModalMgr:activate({TextManipulation.modalKey}, '#FFFFFF', false)
end

hs.urlevent.bind('text-disableVim', function(eventName, params)
    TextManipulation.disableVim()
end)

dofile(TextManipulation.spoonPath .. '/case.lua')
dofile(TextManipulation.spoonPath .. '/yank.lua')
dofile(TextManipulation.spoonPath .. '/paste.lua')
dofile(TextManipulation.spoonPath .. '/change.lua')
dofile(TextManipulation.spoonPath .. '/destroy.lua')
dofile(TextManipulation.spoonPath .. '/select-until.lua')
dofile(TextManipulation.spoonPath .. '/select-inside.lua')

return TextManipulation
