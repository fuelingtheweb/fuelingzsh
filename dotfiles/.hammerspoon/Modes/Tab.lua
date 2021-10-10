local Tab = {}
Tab.__index = Tab

Tab.lookup = {
    y = nil,
    u = nil,
    i = 'first',
    o = 'last',
    p = 'pin',
    open_bracket = 'closeAllToLeft',
    close_bracket = 'closeAllToRight',
    h = 'moveLeft',
    j = 'previous',
    k = 'next',
    l = 'moveRight',
    semicolon = 'closeCurrent',
    quote = 'moveToNewWindow',
    return_or_enter = 'restore',
    n = 'new',
    m = 'closeCurrent',
    comma = 'closePrevious',
    period = 'closeNext',
    slash = 'closeAllOthers',
    right_shift = 'closeAll',
    spacebar = nil,
}

function Tab.first()
    fastKeyStroke({'cmd'}, '1')
end

function Tab.last()
    fastKeyStroke({'cmd'}, '9')
end

function Tab.pin()
    -- Chrome: Pin Tab
    fastKeyStroke('t')
    fastKeyStroke('p')
end


function Tab.previous()
    if appIs(tableplus) then
        fastKeyStroke({'cmd'}, '[')
    elseif appIncludes({teams, discord}) then
        -- Teams: Move to next conversation / channel
        fastKeyStroke({'alt'}, 'down')
    else
        fastKeyStroke({'shift', 'cmd'}, '[')
    end
end

function Tab.next()
    if appIs(tableplus) then
        fastKeyStroke({'cmd'}, ']')
    elseif appIncludes({teams, discord}) then
        -- Teams: Move to previous conversation / channel
        fastKeyStroke({'alt'}, 'up')
    else
        fastKeyStroke({'shift', 'cmd'}, ']')
    end
end

function Tab.moveLeft()
    if appIs(chrome) then
        -- Vimium
        fastKeyStroke('escape')
        insertText('th')
    elseif appIs(atom) then
        fastKeyStroke({'shift', 'alt', 'cmd'}, 'left')
    elseif appIs(sublime) then
        -- https://packagecontrol.io/packages/MoveTab
        fastKeyStroke({'shift', 'alt', 'cmd'}, 'left')
    elseif appIs(iterm) then
        fastKeyStroke({'shift', 'cmd'}, 'left')
    end
end

function Tab.moveRight()
    if appIs(chrome) then
        -- Vimium
        fastKeyStroke('escape')
        insertText('tl')
    elseif appIs(atom) then
        fastKeyStroke({'shift', 'alt', 'cmd'}, 'right')
    elseif appIs(sublime) then
        -- https://packagecontrol.io/packages/MoveTab
        fastKeyStroke({'shift', 'alt', 'cmd'}, 'right')
    elseif appIs(iterm) then
        fastKeyStroke({'shift', 'cmd'}, 'right')
    end
end

function Tab.closeCurrent()
    closeWindow()
end

function Tab.restore()
    fastKeyStroke({'shift', 'cmd'}, 't')
end

function Tab.moveToNewWindow()
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

function Tab.new()
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

function Tab.closeAllToLeft()
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

function Tab.closeAllToRight()
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

function Tab.closeAllOthers()
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

function Tab.closeAll()
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

function Tab.closePrevious()
    Tab.previous()
    Tab.closeCurrent()
    Tab.next()
end

function Tab.closeNext()
    Tab.next()
    Tab.closeCurrent()
end

return Tab
