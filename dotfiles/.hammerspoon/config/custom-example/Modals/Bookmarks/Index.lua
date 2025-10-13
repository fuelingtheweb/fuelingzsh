local mdl = {}
mdl.__index = mdl

local load = Modal.loadFactory('config.custom.Modals.Bookmarks')

Modal.add({
    key = 'OpenBookmarks',
    title = 'Open Bookmark',
    items = {
        r = load('Code'),
        d = load('Docs'),
    },
    callback = function(item)
        Modal.exit()

        if item.callback then
            item.callback()
        elseif item.url then
            fn.open(item.url)
        elseif item.incognito then
            fn.Chrome.openIncognito(item.incognito)
        elseif item.code then
            local path = fn.window.path()

            if not path then
                return
            end

            fn.Code.open(path .. '/' .. item.code)
        else
            item.method(item.value)
        end
    end
})

return mdl
