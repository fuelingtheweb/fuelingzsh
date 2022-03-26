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
    ks.sequence({'t', 'p'})
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
        ks.escape().type('th')
    elseif inCodeEditor() then
        ks.shiftAltCmd('left')
    elseif appIs(iterm) then
        ks.shiftCmd('left')
    end
end

function Tab.moveRight()
    if appIs(chrome) then
        -- Vimium
        ks.escape().type('tl')
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
        ks.cmd('a').copy().close().key('space').shiftCmd('n').key('p')
    elseif appIs(chrome) then
        ks.shift('w')
    end
end

function Tab.new()
    if inCodeEditor() then
        ks.cmd('n')
        hs.timer.doAfter(0.1, function() ks.key('i').enter().up() end)
    elseif appIs(finder) then
        ks.cmd('n')
    else
        ks.cmd('t')
    end
end

function Tab.closeAllToLeft()
    if appIs(chrome) then
        ks.type('txh')
    elseif appIncludes({atom, sublime}) then
        ks.super('tab').sequence({'x', 'h'})

        if appIs(sublime) then ks.type('Close Tabs to Left').enter() end
    end
end

function Tab.closeAllToRight()
    if appIs(chrome) then
        ks.type('txl')
    elseif appIncludes({atom, sublime}) then
        ks.super('tab').sequence({'x', 'l'})

        if appIs(sublime) then ks.type('Close Tabs to Right').enter() end
    end
end

function Tab.closeAllOthers()
    if appIs(chrome) then
        ks.type('tx;')
    elseif appIs(vscode) then
        ks.super('e').super('/')
    elseif appIncludes({atom, sublime}) then
        ks.super('tab').sequence({'x', ';'})

        if appIs(sublime) then ks.type('Close Other Tabs').enter() end
    end
end

function Tab.closeAll()
    if appIs(atom) then
        ks.super('x')
    elseif appIs(sublime) then
        ks.super('tab').sequence({'x', ';'})

        if appIs(sublime) then ks.type('Close All Tabs').enter() end
    elseif appIs(vscode) then
        ks.super('e').super('[')
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
