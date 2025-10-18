local Vi = {}
Vi.__index = Vi

hs.urlevent.bind('vi.moveToTopOfPage', function()
    if cm.Window.scrolling then
        ks.sequence({'g', 'g'})
    elseif is.finder() then
        ks.alt('up')
    elseif is.In(tableplus) then
        cm.Window.enableScrolling()
        hs.timer.doAfter(0.2, function()
            ks.key('g').key('g').escape()
        end)
    else
        ks.cmd('up')
    end
end)

hs.urlevent.bind('vi.moveToBottomOfPage', function()
    if cm.Window.scrolling then
        ks.shift('g')
    elseif is.In(slack, tableplus) then
        cm.Window.enableScrolling()
        hs.timer.doAfter(0.2, function()
            ks.shift('g').escape()
        end)
    elseif is.finder() then
        ks.alt('down')
    else
        ks.cmd('down')
    end
end)

return Vi
