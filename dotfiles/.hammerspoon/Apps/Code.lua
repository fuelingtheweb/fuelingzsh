local Code = {}
Code.__index = Code

Code.windowsWithSnippetsInitialized = {}

function Code.run(name)
    Code.listCommands(name)
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
    hs.execute('export PATH=/Users/nathan/.nvm/versions/node/v17.0.1/bin:/Users/nathan/Development/FuelingTheWeb/bin:/Users/nathan/.fuelingzsh/bin:/Users/nathan/.composer/vendor/bin:/Users/nathan/.yarn/bin:/Users/nathan/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/nathan/.fig/bin:/Users/nathan/.local/bin:/usr/local/opt/fzf/bin; /usr/local/bin/code "'
        .. path:gsub('~', '/Users/nathan') .. '"')
    cm.Window.maximizeAfterDelay()
end

function Code.ensureInitializedSnippets(callback)
    local window = hs.window.focusedWindow()

    if not is.vscode()
        or hs.fnutils.contains(Code.windowsWithSnippetsInitialized, window:id())
    then
        return callback()
    end

    ks.ctrlCmd('s')

    hs.timer.doAfter(0.1, function()
        ks.escape()

        callback()

        table.insert(Code.windowsWithSnippetsInitialized, window:id())
    end)
end

function Code.new()
    hs.application.launchOrFocusByBundleID(vscode)

    hs.timer.doAfter(0.2, function()
        cm.Tab.new()
    end)
end

function Code.listCommands(name)
    ks.slow().shiftCmd('p').type(name)
end

return Code
