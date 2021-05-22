local Modal = {}
Modal.__index = Modal

spoon.ModalMgr = hs.loadSpoon('vendor/ModalMgr')

Modal.modals = {}
Modal.timer = nil

function Modal.addWithMenubar(meta)
    meta = meta or {}
    meta.menubar = hs.menubar.newWithPriority(hs.menubar.priorities['system']):setTitle(''):returnToMenuBar()

    return Modal.add(meta)
end

function Modal.add(meta)
    spoon.ModalMgr:new(meta.key)
    meta.modal = spoon.ModalMgr.modal_list[meta.key]

    Modal.modals[meta.key] = meta

    meta.modal:bind('', 'escape', nil, function()
        spoon.ModalMgr:deactivate({meta.key})
        fastKeyStroke('escape')
    end)

    meta.modal.entered = function()
        if meta.entered then
            meta.entered()
        end

        if meta.menubar and meta.title then
            if type(meta.title) == 'function' then
                return meta.menubar:setTitle(meta.title())
            end

            meta.menubar:setTitle(meta.title)
        end
    end

    meta.modal.exited = function()
        if meta.exited then
            meta.exited()
        end

        if meta.menubar then
            meta.menubar:setTitle('')
        end
    end

    if meta.shortcuts.items then
        each(meta.shortcuts.items, function(item, key)
            if type(item) == 'function' then
                return meta.modal:bind('', key, item.name or nil, item)
            end

            meta.modal:bind('', item.key, item.name or nil, function()
                meta.shortcuts.callback(item)
            end)
        end)
    elseif meta.shortcuts then
        each(meta.shortcuts, function(callback, key)
            meta.modal:bind('', key, nil, callback)
        end)
    end
end

function Modal.enter(key, exitAfter)
    if Modal.timer and Modal.timer:running() then
        Modal.timer:stop()
    end

    spoon.ModalMgr:activate({key}, '#FFFFFF', false)

    if exitAfter then
        Modal.timer = hs.timer.doAfter(exitAfter, function()
            Modal.exit()
        end)
    end
end

function Modal.exit(key)
    if key then
        spoon.ModalMgr:deactivate({key})
    else
        spoon.ModalMgr:deactivateAll()
    end
end

return Modal
