local Arc = {}
Arc.__index = Arc

Arc.url = nil

Modal.add({
    key = 'Arc',
    title = 'Choose Space',
    items = {
        ['c'] = 'Current',
        ['x'] = 'Misc',
        ['m'] = 'Primary',
        ['h'] = 'Hubventory',
        ['b'] = 'Beck',
    },
    callback = function(spaceName)
        fn.Arc.openIn(Arc.url, spaceName)

        Modal.exit()
    end,
    exited = function()
        Arc.url = nil
    end,
})

function Arc.enterModal(url)
    Arc.url = url or nil
    Modal.enter('Arc')
end

function Arc.open(url)
    Arc.enterModal(url)
end

return Arc
