local iTerm = {}
iTerm.__index = iTerm

function iTerm.open(path)
    iTerm.launch(function()
        hs.execute('open -a iTerm "' .. path .. '"')
    end)
end

function iTerm.openNew(path)
    hs.execute('open -a iTerm "' .. path .. '"')
end

function iTerm.launch(callback)
    local app = hs.application.get(iterm)

    if app and app:isRunning() then
        iTerm.triggerShortcut(callback)
    else
        hs.application.open(iterm)
        hs.timer.doAfter(1, function()
            iTerm.triggerShortcut(callback)
        end)
    end
end

function iTerm.triggerShortcut(callback)
    ks.key('`')

    if callback then
        callback()
    end
end

return iTerm
