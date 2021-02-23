local TextManipulation = {}
TextManipulation.__index = TextManipulation
TextManipulation.spoonPath = '/Users/nathan/.hammerspoon/Spoons/TextManipulation.spoon'

TextManipulation.wrapperKeyLookup = {
    t = {mods = {}, key = 't'}, -- t -> tag
    s = {mods = {}, key = "'"}, -- s -> single quotes
    d = {mods = {'shift'}, key = "'"}, -- d -> double quotes
    z = {mods = {}, key = 'z'}, -- z -> back ticks
    f = {mods = {'shift'}, key = '9'}, -- f -> parenthesis
    c = {mods = {'shift'}, key = '['}, -- c -> braces
    b = {mods = {}, key = '['}, -- b -> brackets
}

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

return TextManipulation
