local Tab = {}
Tab.__index = Tab

Tab.lookup = {
    j = 'previous',
    k = 'next',
    m = 'closeCurrent',

    comma = function ()
        md.Tab.previous()
        md.Tab.closeCurrent()

        if is.notIn(vscode) then
            md.Tab.next()
        end
    end,

    period = function ()
        md.Tab.next()
        md.Tab.closeCurrent()

        if is.vscode() or is.chrome() then
            md.Tab.previous()
        end
    end,
}

function Tab.previous()
    if is.In(tableplus) then
        ks.cmd('[')
    elseif is.In(discord) then
        -- Move to next conversation / channel
        ks.alt('down')
    elseif is.In(tinkerwell) then
        ks.altCmd('left')
    elseif is.In(arc, vivaldi, zen) then
        ks.shiftCmd(']')
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
    elseif is.In(arc, vivaldi, zen) then
        ks.shiftCmd('[')
    else
        ks.shiftCmd(']')
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

return Tab
