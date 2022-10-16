local mdl = {}
mdl.__index = mdl

Modal.add({
    key = 'Amethyst',
    title = 'Amethyst',
    allowRepeating = true,
    items = {
        w = {name = 'wideLayout'},
        t = {name = 'tallLayout'},
        i = {name = 'focusSpace1'},
        o = {name = 'focusSpace2'},
        ['['] = {name = 'decreasePaneCount'},
        [']'] = {name = 'increasePaneCount'},
        d = {name = 'displayCurrentLayout'},
        f = {name = 'fullscreenLayout'},
        h = {name = 'shrink'},
        j = {name = 'moveFocusClockwise'},
        k = {name = 'moveFocusCounterClockwise'},
        l = {name = 'expand'},
        [';'] = {name = 'throwToSpace1'},
        ["'"] = {name = 'throwToSpace2'},
        ['return'] = {name = 'floatingLayout'},
        n = {name = 'close'},
        m = {name = 'destroy'},
        [','] = {name = 'swapFocusedWindowCounterClockwise'},
        ['.'] = {name = 'swapFocusedWindowClockwise'},
        space = {name = 'toggleFloatForFocusedWindow'},
    },
    callback = function(item)
        mdl[item.name]()
    end,
})

function mdl.wideLayout()
    ks.shiftAlt('s')
end

function mdl.tallLayout()
    ks.shiftAlt('x')
end

function mdl.focusSpace1()
    Modal.exit()

    ks.ctrl('1')

    hs.timer.doAfter(0.2, function()
        Modal.enter('Amethyst')
    end)
end

function mdl.focusSpace2()
    Modal.exit()

    ks.ctrl('2')

    hs.timer.doAfter(0.2, function()
        Modal.enter('Amethyst')
    end)
end

function mdl.fullscreenLayout()
    ks.shiftAlt('d')
end

function mdl.decreasePaneCount()
    ks.shiftAlt('.')
end

function mdl.increasePaneCount()
    ks.shiftAlt(',')
end

function mdl.shrink()
    ks.shiftAlt('h')
end

function mdl.moveFocusClockwise()
    ks.shiftAlt('k')
end

function mdl.moveFocusCounterClockwise()
    ks.shiftAlt('j')
end

function mdl.expand()
    ks.shiftAlt('l')
end

function mdl.throwToSpace1()
    ks.shiftAltCmd('h')
end

function mdl.throwToSpace2()
    ks.shiftAltCmd('l')
end

function mdl.floatingLayout()
    ks.shiftAlt('v')
end

function mdl.close()
    ks.shiftCmd('w')
end

function mdl.destroy()
    cm.Window.destroy()
end

function mdl.swapFocusedWindowCounterClockwise()
    ks.shiftAltCmd('j')
end

function mdl.swapFocusedWindowClockwise()
    ks.shiftAltCmd('k')
end

function mdl.displayCurrentLayout()
    ks.shiftAlt('i')
end

function mdl.toggleFloatForFocusedWindow()
    ks.shiftAlt('t')
end

return mdl
