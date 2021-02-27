local SelectUntilModal = {}
SelectUntilModal.__index = SelectUntilModal

hs.loadSpoon('ModalMgr')

SelectUntilModal.active = false
SelectUntilModal.direction = nil
SelectUntilModal.key = nil
SelectUntilModal.menuBar = hs.menubar.newWithPriority(hs.menubar.priorities['system']):setTitle(''):returnToMenuBar();
SelectUntilModal.modalKey = 'SelectUntilModal'

spoon.ModalMgr:new(SelectUntilModal.modalKey)
SelectUntilModal.modal = spoon.ModalMgr.modal_list[SelectUntilModal.modalKey]

SelectUntilModal.modal:bind('', 'escape', nil, function()
    spoon.ModalMgr:deactivate({SelectUntilModal.modalKey})
    hs.eventtap.keyStroke({}, 'escape', 0)
end)

SelectUntilModal.modal.entered = function()
    SelectUntilModal.active = true
    SelectUntilModal.menuBar:setTitle('SelectUntilModal: ' .. (SelectUntilModal.direction or '') .. ' ' .. (SelectUntilModal.key or ''))
end

SelectUntilModal.modal.exited = function()
    SelectUntilModal.active = false
    SelectUntilModal.direction = nil
    SelectUntilModal.key = nil
    SelectUntilModal.menuBar:setTitle('')
end

SelectUntilModal.pending = false
SelectUntilModal.pendingKey = nil
SelectUntilModal.timer = nil

SelectUntilModal.keys = {}
SelectUntilModal.actions = {}
SelectUntilModal.keymap = {}

function SelectUntilModal:init(keys, actions, keymap, timer)
    SelectUntilModal.keys = keys
    SelectUntilModal.actions = actions
    SelectUntilModal.keymap = keymap
    SelectUntilModal.timer = timer
end

function SelectUntilModal:start()
    each(SelectUntilModal.keys, function(item)
        SelectUntilModal.modal:bind('', item.key, nil, function()
            SelectUntilModal.actions[item.action]()
        end)
    end)
end

function SelectUntilModal:enter(direction, key)
    spoon.ModalMgr:deactivateAll()
    SelectUntilModal.direction = direction or nil
    SelectUntilModal.key = key or nil
    spoon.ModalMgr:activate({SelectUntilModal.modalKey}, '#FFFFFF', false)
end

return SelectUntilModal
