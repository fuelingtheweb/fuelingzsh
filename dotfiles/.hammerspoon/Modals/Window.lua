local mdl = {}
mdl.__index = mdl

local grid = require 'hs.grid'

grid.setGrid('16x10')
grid.setMargins({x = 0, y = 0})

mdl.move = false

Modal.add({
    key = 'Window',
    title = function()
        return mdl.move and 'Window: Move' or 'Window: Resize'
    end,
    allowRepeating = true,
    items = {
        h = {name = 'Move or resize left', method = 'moveOrResizeLeft'},
        j = {name = 'Move or resize down', method = 'moveOrResizeDown'},
        k = {name = 'Move or resize up', method = 'moveOrResizeUp'},
        l = {name = 'Move or resize right', method = 'moveOrResizeRight'},
        r = {name = 'Resize', method = function()
            mdl.move = false
            Modal.enter('Window')
        end},
        m = {name = 'Move', method = function()
            mdl.move = true
            Modal.enter('Window')
        end},
    },
    callback = function(item)
        if is.Function(item.method) then
            item.method()
        else
            mdl[item.method]()
        end
    end,
})

function mdl.moveOrResizeLeft()
    return mdl.move and grid.pushWindowLeft() or grid.resizeWindowThinner()
end

function mdl.moveOrResizeDown()
    return mdl.move and grid.pushWindowDown() or grid.resizeWindowTaller()
end

function mdl.moveOrResizeUp()
    return mdl.move and grid.pushWindowUp() or grid.resizeWindowShorter()
end

function mdl.moveOrResizeRight()
    return mdl.move and grid.pushWindowRight() or grid.resizeWindowWider()
end

return mdl
