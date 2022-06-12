local Tab = {}
Tab.__index = Tab

function Tab.first()
    ks.cmd('1')
end

function Tab.last()
    if is.chrome() then
        ks.cmd('9')
    else
        ks.ctrl('0')
    end
end

function Tab.pin()
    -- Chrome: Pin Tab
    ks.sequence({'t', 'p'})
end

function Tab.previous()
    if is.In(tableplus) then
        ks.cmd('[')
    elseif is.In(discord) then
        -- Move to next conversation / channel
        ks.alt('down')
    elseif is.In(tinkerwell) then
        ks.altCmd('left')
    else
        ks.shiftCmd('[')
    end
end

function Tab.next()
    if is.In(tableplus) then
        ks.cmd(']')
    elseif is.In(discord) then
        -- Move to previous conversation / channel
        ks.alt('up')
    elseif is.In(tinkerwell) then
        ks.altCmd('right')
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
    if is.chrome() then
        ks.shift('w')
    end
end

function Tab.moveToNextWindow()
    local app = hs.application.frontmostApplication()

    if fn.table.count(app:visibleWindows()) < 2 then
        return
    end

    if is.chrome() then
        fn.Chrome.copyUrl()
        cm.Window.nextInCurrentApp()
        cm.Tab.new()
        ks.paste().enter()
        cm.Window.nextInCurrentApp()
        ks.close()
    end
end

function Tab.new()
    if is.codeEditor() then
        ks.cmd('n')

        hs.timer.doAfter(0.1, function()
            ks.key('i').enter().slow().escape().up().key('i')
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
    end
end

function Tab.closeAllToRight()
    if is.chrome() then
        ks.type('txl')
    elseif is.vscode() then
        ks.super('e').super(']')
    end
end

function Tab.closeAllOthers()
    if is.chrome() then
        ks.type('tx;')
    elseif is.vscode() then
        ks.super('e').super('/')
    end
end

function Tab.closeAll()
    if is.vscode() then
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

    if is.vscode() or is.chrome() then
        Tab.previous()
    end
end

return Tab
