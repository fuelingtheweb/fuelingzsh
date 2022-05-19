local Code = {}
Code.__index = Code

function Code.run(name)
    ks.slow().shiftCmd('p').type(name)
    hs.timer.doAfter(0.3, ks.enter)
end

function Code.openFile(file)
    ks.slow().cmd('t').type(file)
    hs.timer.doAfter(0.3, ks.enter)
end

function Code.open(path)
    local app = hs.application.find(vscode)

    if not app then
        Code.openAndMaximize(path)
    else
        local window = nil

        fn.each(hs.window.filter.new(app:name()):getWindows(), function(w)
            if not window and str.contains(path, w:title()) then
                window = w
            end
        end)

        if window then
            window:focus()
        else
            Code.openAndMaximize(path)
        end
    end
end

function Code.openAndMaximize(path)
    hs.execute('export PATH=/Users/nathan/.nvm/versions/node/v17.0.1/bin:/Users/nathan/Development/FuelingTheWeb/bin:/Users/nathan/.fuelingzsh/bin:/Users/nathan/.composer/vendor/bin:/Users/nathan/.yarn/bin:/Users/nathan/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/nathan/.fig/bin:/Users/nathan/.local/bin:/usr/local/opt/fzf/bin; /usr/local/bin/code "' .. path:gsub('~', '/Users/nathan') .. '"')
    cm.Window.maximizeAfterDelay()
end

function Code.new()
    hs.application.launchOrFocusByBundleID(vscode)

    hs.timer.doAfter(0.2, function()
        cm.Tab.new()
    end)
end

return Code
