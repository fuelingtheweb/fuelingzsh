local Tab = {}
Tab.__index = Tab

function Tab.first()
    ks.cmd('1')
end

function Tab.last()
    ks.cmd('9')
end

function Tab.pin()
    -- Chrome: Pin Tab
    ks.sequence({'t', 'p'})
end

function Tab.previous()
    if is.In(tableplus) then
        ks.cmd('[')
    elseif is.In(teams, discord) then
        -- Teams: Move to next conversation / channel
        ks.alt('down')
    else
        ks.shiftCmd('[')
    end
end

function Tab.next()
    if is.In(tableplus) then
        ks.cmd(']')
    elseif is.In(teams, discord) then
        -- Teams: Move to previous conversation / channel
        ks.alt('up')
    else
        ks.shiftCmd(']')
    end
end

function Tab.moveLeft()
    if is.chrome() then
        -- Vimium
        ks.escape().type('th')
    elseif is.codeEditor() then
        ks.shiftAltCmd('left')
    elseif is.iterm() then
        ks.shiftCmd('left')
    end
end

function Tab.moveRight()
    if is.chrome() then
        -- Vimium
        ks.escape().type('tl')
    elseif is.codeEditor() then
        ks.shiftAltCmd('right')
    elseif is.iterm() then
        ks.shiftCmd('right')
    end
end

function Tab.closeCurrent()
    ks.close()

    if is.chrome() then
        hs.timer.doAfter(1, function()
            app = hs.application.frontmostApplication()

            if next(app:visibleWindows()) == nil then
                app:hide()
            end
        end)
    end
end

function Tab.restore()
    ks.shiftCmd('t')
end

function Tab.moveToNewWindow()
    if is.sublime() then
        ks.cmd('a').copy().close().key('space').shiftCmd('n').key('p')
    elseif is.chrome() then
        ks.shift('w')
    end
end

function Tab.new()
    if is.codeEditor() then
        ks.cmd('n')
        hs.timer.doAfter(0.1, function()
            ks.key('i').enter().up()
        end)
    elseif is.finder() then
        ks.cmd('n')
    else
        ks.cmd('t')
    end
end

function Tab.closeAllToLeft()
    if is.chrome() then
        ks.type('txh')
    elseif is.vscode() then
        ks.super('e').super('[')
    elseif is.In(atom, sublime) then
        ks.super('tab').sequence({'x', 'h'})

        if is.sublime() then
            ks.type('Close Tabs to Left').enter()
        end
    end
end

function Tab.closeAllToRight()
    if is.chrome() then
        ks.type('txl')
    elseif is.vscode() then
        ks.super('e').super(']')
    elseif is.In(atom, sublime) then
        ks.super('tab').sequence({'x', 'l'})

        if is.sublime() then
            ks.type('Close Tabs to Right').enter()
        end
    end
end

function Tab.closeAllOthers()
    if is.chrome() then
        ks.type('tx;')
    elseif is.vscode() then
        ks.super('e').super('/')
    elseif is.In(atom, sublime) then
        ks.super('tab').sequence({'x', ';'})

        if is.sublime() then
            ks.type('Close Other Tabs').enter()
        end
    end
end

function Tab.closeAll()
    if is.In(atom) then
        ks.super('x')
    elseif is.sublime() then
        ks.super('tab').sequence({'x', ';'})

        if is.sublime() then
            ks.type('Close All Tabs').enter()
        end
    elseif is.vscode() then
        ks.super('e').super("'")
    end
end

function Tab.closePrevious()
    Tab.previous()
    Tab.closeCurrent()

    if is.notIn(vscode) then
        Tab.next()
    end
end

function Tab.closeNext()
    Tab.next()
    Tab.closeCurrent()

    if is.vscode() then
        Tab.previous()
    end
end

function Tab.manage()
    if is.chrome() then
        ks.shiftCmd('m')
    end
end

return Tab
