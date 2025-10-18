local mdl = {}
mdl.__index = mdl

Modal.add({
    key = 'OpenFrequent',
    title = 'Open Frequent',
    items = {
        a = {name = 'Aliases', code = '~/Dev/Anvil/aliases'},
        s = {name = 'Snippets', code = '~/Dev/Anvil/custom/espanso'},
        h = {name = 'Hammerspoon', code = '~/.hammerspoon'},
        d = {
            name = 'Downloads',
            callback = function() hs.execute('open ~/Downloads') end
        },
        z = {name = 'Anvil', code = '~/Dev/Anvil'},
    },
    callback = function(item)
        Modal.exit()

        if item.callback then
            item.callback()
        elseif item.url then
            fn.Vivaldi.open(item.url)
        elseif item.incognito then
            fn.Chrome.openIncognito(item.incognito)
        elseif item.code then
            fn.Code.open(item.code)
        else
            item.method(item.value)
        end
    end
})

return mdl
