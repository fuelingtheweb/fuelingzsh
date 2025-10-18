local Terminal = {}
Terminal.__index = Terminal

terminalName = 'Warp'
terminalBundle = warp

function Terminal.open(path)
    Terminal.launch(function()
        hs.execute('open -a ' .. terminalName .. ' "' .. path .. '"')
    end)
end

function Terminal.openNew(path)
    hs.execute('open -a ' .. terminalName .. ' "' .. path .. '"')
end

function Terminal.launch(callback)
    local app = hs.application.get(terminalBundle)

    if app and app:isRunning() then
        Terminal.triggerShortcut(callback)
    else
        hs.application.open(terminalBundle)
        hs.timer.doAfter(1, function()
            Terminal.triggerShortcut(callback)
        end)
    end
end

function Terminal.triggerShortcut(callback)
    ks.key('`')

    if callback then
        callback()
    end
end

return Terminal
