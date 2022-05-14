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
    app = hs.application.get(iterm)

    if app and app:isRunning() then
        triggerItermShortcut(callback)
    else
        hs.application.open(iterm)
        hs.timer.doAfter(1, function()
            triggerItermShortcut(callback)
        end)
    end
end

return iTerm
