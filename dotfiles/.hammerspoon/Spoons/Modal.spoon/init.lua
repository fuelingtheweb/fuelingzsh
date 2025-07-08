local Modal = {}
Modal.__index = Modal

spoon.ModalMgr = hs.loadSpoon('vendor/ModalMgr')

Modal.last = nil
Modal.timer = nil
Modal.showingCheatsheet = false

function Modal.add(meta)
    local modalKey = meta.key or meta.title:gsub(' ', '')

    spoon.ModalMgr:new(modalKey)
    meta.modal = spoon.ModalMgr.modal_list[modalKey]

    meta.modal.entered = function()
        if meta.showCheatsheetOnEnter and Modal.last then
            Modal.exit(Modal.last)
        end

        if meta.entered then
            meta.entered()
        end

        if meta.title then
            if is.Function(meta.title) then
                spoon.ModalMgr.active_title = meta.title()
                return
            end

            spoon.ModalMgr.active_title = meta.title
        end

        if meta.showCheatsheetOnEnter then
            Modal.toggleCheatsheet(modalKey)
        elseif spoon.ModalMgr.which_key:isShowing() then
            spoon.ModalMgr.which_key:hide()
            Modal.toggleCheatsheet(modalKey)
        end

        Modal.last = modalKey
    end

    meta.modal.exited = function()
        if meta.exited then
            meta.exited()
        end

        spoon.ModalMgr.active_title = nil
        Modal.showingCheatsheet = false
    end

    if meta.items then
        fn.each(meta.items, function(item, key)
            if is.Function(item) then
                meta.modal:bind('', key, nil, item)
            elseif is.Table(item) and item.items then
                if not item.callback then
                    item.key = modalKey .. '.' .. (item.key or item.title:gsub(' ', ''))
                    item.callback = meta.callback
                end

                if meta.showCheatsheetOnEnter then
                    item.showCheatsheetOnEnter = meta.showCheatsheetOnEnter
                end

                Modal.add(item)

                meta.modal:bind('', key, item.title or nil, function()
                    Modal.enter(item.key)
                end)
            elseif is.Table(item) and item.key then
                meta.modal:bind(
                    item.shift and {'shift'} or '',
                    item.key,
                    item.name or nil,
                    function() meta.callback(item.value, item.key) end
                )
            elseif is.Table(item) then
                meta.modal:bind('', key, item.name or nil, function()
                    meta.callback(item, key)
                end, nil, meta.allowRepeating and function() meta.callback(item, key) end or nil)
            elseif is.String(item) then
                meta.modal:bind('', key, item, function()
                    if item == 'exit' then
                        return Modal.exit()
                    end

                    meta.callback(item, key)
                end)
            end
        end)
    elseif meta.keys then
        fn.each(meta.keys, function(key)
            meta.modal:bind('', key, key, function()
                meta.callback(key, key)
            end)
        end)
    elseif meta.shortcuts then
        fn.each(meta.shortcuts, function(callback, key)
            meta.modal:bind('', key, nil, callback)
        end)
    end

    if not meta.items or not meta.items.escape then
        meta.modal:bind('', 'escape', 'Exit', function()
            Modal.exit()
            ks.escape()
        end)
    end

    if not meta.disableDismissWithJ and (not meta.items or not meta.items.j) then
        meta.modal:bind('', 'j', 'Exit', function()
            if meta.beforeExit then
                meta.beforeExit()
            end

            Modal.exit()
        end)
    end

    if not meta.items or not meta.items['-'] then
        meta.modal:bind('', '-', 'Edit Hammerspoon', function()
            Modal.exit()

            fn.Code.open('~/.hammerspoon')
            hs.timer.doAfter(0.1, md.Hyper.open)
        end)
    end

    if meta.defaults == nil or meta.defaults == true then
        meta.modal:bind('', '/', 'Cheatsheet', function()
            Modal.toggleCheatsheet(modalKey)
        end)

        fn.each({
            'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
            'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
        }, function(key)
            meta.modal:bind({'shift'}, key, nil, function()
                Modal.exit()
                ks.shift(key)
            end)
        end)
    end

    if meta.fillEmpty then
        fn.each({
            'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'k', 'l', 'm',
            'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
        }, function(key)
            if not meta.items[key] then
                meta.modal:bind({}, key, nil, function()
                    Modal.exit()
                    ks.key(key)
                end)
            end
        end)
    end
end

function Modal.enter(key, exitAfter)
    -- if key == 'TextManipulation:vimDisabled' then
    --     spoon.ModalMgr:activate({key}, '#212d33', false)
    -- else
        spoon.ModalMgr:activate({key}, '#1A1C1E', false)
    -- end

    if Modal.timer and Modal.timer:running() then
        Modal.timer:stop()
    end

    if exitAfter then
        Modal.timer = hs.timer.doAfter(exitAfter, function()
            Modal.exit(key)
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

function Modal.loadCustom(modal)
    return require('config.custom.Modals.' .. modal)
end

function Modal.load(modal)
    return require('Modals.' .. modal)
end

function Modal.loadFactory(basePath)
    return function(nestedPath)
        local meta = require(basePath .. '.' .. nestedPath)

        return {
            title = nestedPath,
            items = meta,
        }
    end
end

return Modal
