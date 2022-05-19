local mdl = {}
mdl.__index = mdl

Modal.add({
    key = 'Scrolling',
    title = 'Scrolling',
    defaults = false,
    disableDismissWithJ = true,
    entered = function()
        cm.Window.scrolling = true
    end,
    exited = function()
        cm.Window.scrolling = false
    end,
})

return mdl
