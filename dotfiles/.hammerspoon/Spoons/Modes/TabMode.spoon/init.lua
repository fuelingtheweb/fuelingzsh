local TabMode = {}
TabMode.__index = TabMode

function TabMode.y()
end

function TabMode.u()
end

function TabMode.i()
    -- Go to first tab
    fastKeyStroke({'cmd'}, '1')
end

function TabMode.o()
    -- Go to last tab
    fastKeyStroke({'cmd'}, '9')
end

function TabMode.p()
    -- Chrome: Pin Tab
    fastKeyStroke('t')
    fastKeyStroke('p')
end

function TabMode.open_bracket()
    TabMode.closeCurrent()
end

function TabMode.close_bracket()
    TabMode.moveToNewWindow()
end

function TabMode.h()
    TabMode.moveLeft()
end

function TabMode.j()
end

function TabMode.k()
end

function TabMode.l()
    TabMode.moveRight()
end

function TabMode.semicolon()
end

function TabMode.quote()
end

function TabMode.return_or_enter()
    TabMode.restore()
end

function TabMode.n()
    TabMode.new()
end

function TabMode.m()
end

function TabMode.comma()
    TabMode.closeAllToLeft()
end

function TabMode.period()
    TabMode.closeAllToRight()
end

function TabMode.slash()
    TabMode.closeAllOthers()
end

function TabMode.right_shift()
    TabMode.closeAll()
end

function TabMode.spacebar()
end

function TabMode.moveLeft()
    if appIs(chrome) then
        -- Vimium
        fastKeyStroke('escape')
        insertText('th')
    elseif appIs(atom) then
        fastKeyStroke({'shift', 'alt', 'cmd'}, 'h')
    elseif appIs(sublime) then
        -- https://packagecontrol.io/packages/MoveTab
        fastKeyStroke({'shift', 'alt', 'cmd'}, 'left')
    elseif appIs(iterm) then
        fastKeyStroke({'shift', 'cmd'}, 'left')
    end
end

function TabMode.moveRight()
    if appIs(chrome) then
        -- Vimium
        fastKeyStroke('escape')
        insertText('tl')
    elseif appIs(atom) then
        fastKeyStroke({'shift', 'alt', 'cmd'}, 'l')
    elseif appIs(sublime) then
        -- https://packagecontrol.io/packages/MoveTab
        fastKeyStroke({'shift', 'alt', 'cmd'}, 'right')
    elseif appIs(iterm) then
        fastKeyStroke({'shift', 'cmd'}, 'right')
    end
end

function TabMode.closeCurrent()
    closeWindow()
end

function TabMode.restore()
    fastKeyStroke({'shift', 'cmd'}, 't')
end

function TabMode.moveToNewWindow()
    if appIs(sublime) then
        fastKeyStroke({'cmd'}, 'a')
        fastKeyStroke({'cmd'}, 'c')
        fastKeyStroke({'cmd'}, 'w')
        fastKeyStroke('space')
        fastKeyStroke({'shift', 'cmd'}, 'n')
        fastKeyStroke('p')
    elseif appIs(chrome) then
        fastKeyStroke({'shift'}, 'w')
    end
end

function TabMode.new()
    if appIncludes({sublime, atom}) then
        fastKeyStroke({'cmd'}, 'n')
        fastKeyStroke('i')
        fastKeyStroke('return')
        fastKeyStroke('up')
    elseif appIs(finder) then
        fastKeyStroke({'cmd'}, 'n')
    else
        fastKeyStroke({'cmd'}, 't')
    end
end

function TabMode.closeAllToLeft()
    if appIs(chrome) then
        insertText('txh')
    elseif appIncludes({atom, sublime}) then
        fastKeyStroke({'ctrl', 'alt', 'cmd'}, 'tab')
        fastKeyStroke('x')
        fastKeyStroke('h')

        if appIs(sublime) then
            insertText('Close Tabs to Left')
            fastKeyStroke('return')
        end
    end
end

function TabMode.closeAllToRight()
    if appIs(chrome) then
        insertText('txl')
    elseif appIncludes({atom, sublime}) then
        fastKeyStroke({'ctrl', 'alt', 'cmd'}, 'tab')
        fastKeyStroke('x')
        fastKeyStroke('l')

        if appIs(sublime) then
            insertText('Close Tabs to Right')
            fastKeyStroke('return')
        end
    end
end

function TabMode.closeAllOthers()
    if appIs(chrome) then
        insertText('tx;')
    elseif appIncludes({atom, sublime}) then
        fastKeyStroke({'ctrl', 'alt', 'cmd'}, 'tab')
        fastKeyStroke('x')
        fastKeyStroke(';')

        if appIs(sublime) then
            insertText('Close Other Tabs')
            fastKeyStroke('return')
        end
    end
end

function TabMode.closeAll()
    if appIs(atom) then
        fastKeyStroke({'ctrl', 'alt', 'cmd'}, 'x')
    elseif appIs(sublime) then
        fastKeyStroke({'ctrl', 'alt', 'cmd'}, 'tab')
        fastKeyStroke('x')
        fastKeyStroke(';')

        if appIs(sublime) then
            insertText('Close All Tabs')
            fastKeyStroke('return')
        end
    end
end

return TabMode
