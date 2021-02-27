local DestroyModal = {}
DestroyModal.__index = DestroyModal

hs.loadSpoon('ModalMgr')

DestroyModal.active = false
DestroyModal.direction = nil
DestroyModal.key = nil
DestroyModal.menuBar = hs.menubar.newWithPriority(hs.menubar.priorities['system']):setTitle(''):returnToMenuBar();
DestroyModal.modalKey = 'DestroyModal'

spoon.ModalMgr:new(DestroyModal.modalKey)
DestroyModal.modal = spoon.ModalMgr.modal_list[DestroyModal.modalKey]

DestroyModal.modal:bind('', 'escape', nil, function()
    spoon.ModalMgr:deactivate({DestroyModal.modalKey})
    hs.eventtap.keyStroke({}, 'escape', 0)
end)

DestroyModal.modal.entered = function()
    DestroyModal.active = true
    DestroyModal.menuBar:setTitle('DestroyModal: ' .. (DestroyModal.direction or '') .. ' ' .. (DestroyModal.key or ''))
end

DestroyModal.modal.exited = function()
    DestroyModal.active = false
    DestroyModal.direction = nil
    DestroyModal.key = nil
    DestroyModal.menuBar:setTitle('')
end

DestroyModal.pending = false
DestroyModal.pendingKey = nil

DestroyModal.keys = {}
DestroyModal.actions = {}
DestroyModal.keymap = {}

function DestroyModal:init(keys, actions, keymap)
    DestroyModal.keys = keys
    DestroyModal.actions = actions
    DestroyModal.keymap = keymap
end

function DestroyModal:start()
    each(DestroyModal.keys, function(item)
        DestroyModal.modal:bind('', item.key, nil, function()
            DestroyModal.actions[item.action]()
        end)
    end)
end

function DestroyModal:enter(direction, key)
    spoon.ModalMgr:deactivateAll()
    DestroyModal.direction = direction or nil
    DestroyModal.key = key or nil
    spoon.ModalMgr:activate({DestroyModal.modalKey}, '#FFFFFF', false)
end

return DestroyModal
