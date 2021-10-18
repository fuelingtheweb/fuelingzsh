local Modal = {}
Modal.__index = Modal

spoon.ModalMgr = hs.loadSpoon('vendor/ModalMgr')

Modal.timer = nil
Modal.menubar = hs.menubar.newWithPriority(hs.menubar.priorities['system']):setTitle(''):returnToMenuBar()

function Modal.add(meta)
    spoon.ModalMgr:new(meta.key)
    meta.modal = spoon.ModalMgr.modal_list[meta.key]

    meta.modal.entered = function()
        if meta.entered then
            meta.entered()
        end

        if meta.title then
            if type(meta.title) == 'function' then
                return Modal.menubar:setTitle(meta.title())
            end

            Modal.menubar:setTitle(meta.title)
        end

        if meta.showCheatsheetOnEnter then
            Modal.toggleCheatsheet(meta.key)
        end
    end

    meta.modal.exited = function()
        if meta.exited then
            meta.exited()
        end

        Modal.menubar:setTitle('')
    end

    if meta.items then
        each(meta.items, function(item, key)
            if isFunction(item) then
                meta.modal:bind('', key, nil, item)
            elseif isTable(item) and item.items then
                if not item.callback then
                    item.key = meta.key .. '.' .. item.key
                    item.callback = meta.callback
                end

                if meta.showCheatsheetOnEnter then
                    item.showCheatsheetOnEnter = meta.showCheatsheetOnEnter
                end

                Modal.add(item)

                meta.modal:bind('', key, item.title or nil, function()
                    Modal.exit()
                    Modal.enter(item.key)
                end)
            elseif isTable(item) and item.key then
                meta.modal:bind(item.shift and {'shift'} or '', item.key, item.name or nil, function()
                    meta.callback(item.value)
                end)
            elseif isTable(item) then
                meta.modal:bind('', key, item.name or nil, function()
                    meta.callback(item)
                end)
            elseif isString(item) then
                meta.modal:bind('', key, item, function()
                    if item == 'exit' then
                        return Modal.exit()
                    end

                    meta.callback(item)
                end)
            end
        end)
    elseif meta.keys then
        each(meta.keys, function(key)
            meta.modal:bind('', key, key, function()
                meta.callback(key)
            end)
        end)
    elseif meta.shortcuts then
        each(meta.shortcuts, function(callback, key)
            meta.modal:bind('', key, nil, callback)
        end)
    end

    if not meta.items or not meta.items.escape then
        meta.modal:bind('', 'escape', 'Exit', function()
            Modal.exit(meta.key)
            fastKeyStroke('escape')
        end)
    end

    if not meta.items or not meta.items.j then
        meta.modal:bind('', 'j', 'Exit', function()
            if meta.beforeExit then
                meta.beforeExit()
            end

            Modal.exit(meta.key)
        end)
    end

    if meta.defaults == nil or meta.defaults == true then
        meta.modal:bind('', '/', 'Cheatsheet', function()
            Modal.toggleCheatsheet()
        end)

        each(
            {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'},
            function(key)
                meta.modal:bind({'shift'}, key, nil, function()
                    Modal.exit()
                    fastKeyStroke({'shift'}, key)
                end)
            end
        )
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

function Modal.toggleCheatsheet(key)
    if key then
        spoon.ModalMgr:toggleCheatsheet({key})
    else
        spoon.ModalMgr:toggleCheatsheet()
    end
end

return Modal
