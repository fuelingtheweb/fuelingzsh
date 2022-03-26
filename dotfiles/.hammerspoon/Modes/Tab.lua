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
    semicolon = nil,
    quote = 'moveToNewWindow',
    return_or_enter = 'restore',
    n = 'new',
    m = 'closeCurrent',
    comma = 'closePrevious',
    period = 'closeNext',
    slash = 'closeAllOthers',
    right_shift = 'closeAll',
    spacebar = 'manage'
}

function Tab.first() ks.cmd('1') end

function Tab.last() ks.cmd('9') end

function Tab.pin()
    -- Chrome: Pin Tab
    ks.key('t')
    ks.key('p')
end

function Tab.previous()
    if appIs(tableplus) then
        ks.cmd('[')
    elseif appIncludes({teams, discord}) then
        -- Teams: Move to next conversation / channel
        ks.alt('down')
    else
        ks.shiftCmd('[')
    end
end

function Tab.next()
    if appIs(tableplus) then
        ks.cmd(']')
    elseif appIncludes({teams, discord}) then
        -- Teams: Move to previous conversation / channel
        ks.alt('up')
    else
        ks.shiftCmd(']')
    end
end

function Tab.moveLeft()
    if appIs(chrome) then
        -- Vimium
        ks.escape()
        insertText('th')
    elseif inCodeEditor() then
        ks.shiftAltCmd('left')
    elseif appIs(iterm) then
        ks.shiftCmd('left')
    end
end

function Tab.moveRight()
    if appIs(chrome) then
        -- Vimium
        ks.escape()
        insertText('tl')
    elseif inCodeEditor() then
        ks.shiftAltCmd('right')
    elseif appIs(iterm) then
        ks.shiftCmd('right')
    end
end

function Tab.closeCurrent() closeWindow() end

function Tab.restore() ks.shiftCmd('t') end

function Tab.moveToNewWindow()
    if appIs(sublime) then
        ks.cmd('a')
        ks.cmd('c')
        ks.cmd('w')
        ks.key('space')
        ks.shiftCmd('n')
        ks.key('p')
    elseif appIs(chrome) then
        ks.shift('w')
    end
end

function Tab.new()
    if inCodeEditor() then
        ks.cmd('n')
        hs.timer.doAfter(0.1, function()
            ks.key('i')
            ks.key('return')
            ks.key('up')
        end)
    elseif appIs(finder) then
        ks.cmd('n')
    else
        ks.cmd('t')
    end
end

function Tab.closeAllToLeft()
    if appIs(chrome) then
        insertText('txh')
    elseif appIncludes({atom, sublime}) then
        ks.super('tab')
        ks.key('x')
        ks.key('h')

        if appIs(sublime) then
            insertText('Close Tabs to Left')
            ks.key('return')
        end
    end
end

function Tab.closeAllToRight()
    if appIs(chrome) then
        insertText('txl')
    elseif appIncludes({atom, sublime}) then
        ks.super('tab')
        ks.key('x')
        ks.key('l')

        if appIs(sublime) then
            insertText('Close Tabs to Right')
            ks.key('return')
        end
    end
end

function Tab.closeAllOthers()
    if appIs(chrome) then
        insertText('tx;')
    elseif appIs(vscode) then
        fastSuperks.slow().key('e')
        fastSuperks.slow().key('/')
    elseif appIncludes({atom, sublime}) then
        ks.super('tab')
        ks.key('x')
        ks.key(';')

        if appIs(sublime) then
            insertText('Close Other Tabs')
            ks.key('return')
        end
    end
end

function Tab.closeAll()
    if appIs(atom) then
        ks.super('x')
    elseif appIs(sublime) then
        ks.super('tab')
        ks.key('x')
        ks.key(';')

        if appIs(sublime) then
            insertText('Close All Tabs')
            ks.key('return')
        end
    elseif appIs(vscode) then
        fastSuperks.slow().key('e')
        fastSuperks.slow().key('[')
    end
end

function Tab.closePrevious()
    Tab.previous()
    Tab.closeCurrent()

    if not appIs(vscode) then Tab.next() end
end

function Tab.closeNext()
    Tab.next()
    Tab.closeCurrent()
end

function Tab.manage() if appIs(chrome) then ks.shiftCmd('m') end end

return Tab
