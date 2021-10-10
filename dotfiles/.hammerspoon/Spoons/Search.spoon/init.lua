local Search = {}
Search.__index = Search

function Search.symbol()
    fastKeyStroke({'cmd'}, 'r')
end

function Search.files()
    triggerAlfredSearch('open ')
end

function Search.google()
    triggerAlfredWorkflow('google', 'com.akikoz.alfred.websearchsuggest')
end

function Search.amazon()
    triggerAlfredWorkflow('amazon', 'com.akikoz.alfred.websearchsuggest')
end

function Search.mergeConflicts()
    fastKeyStroke('/')
    insertText('<<<<<')
    fastKeyStroke('return')
end

function Search.default()
    if inCodeEditor() then
        TextManipulation.disableVim()
        fastKeyStroke('/')
    end
end

function Search.tabs()
    if appIs(atom) then
        fastKeyStroke({'cmd'}, 'b')
    elseif appIs(sublime) then
        fastKeyStroke({'alt', 'shift'}, 'p')
    elseif appIs(chrome) then
        fastKeyStroke({'shift'}, 't')
    end
end

function Search.windowsInCurrentApp()
    windows = hs.window.filter.new({hs.application.frontmostApplication():name()}):getWindows(hs.window.filter.sortByFocusedLast)

    Search.loadWindowsInAlfred(windows, 2)
end

function Search.loadWindowsInAlfred(windows, minimum)
    if not windows or countTable(windows) < minimum then
        return
    end

    local items = {}
    each(windows, function(window)
        app = window:application()
        iconPath = '~/.fuelingzsh/custom/' .. app:name() .. '.png'
        hs.image.imageFromAppBundle(app:bundleID()):saveToFile(iconPath)
        table.insert(items, {
            uid = window:id(),
            title = window:title(),
            match = app:name() .. ' ' .. window:title(),
            arg = window:id(),
            icon = {
                path = iconPath,
            },
        })
    end)

    hs.json.write({items = items}, '/Users/nathan/.fuelingzsh/custom/windows.json', false, true)

    triggerAlfredWorkflow('windows', 'com.fuelingtheweb.commands')
end

function Search.allWindows()
    windows = hs.window.filter.default
        :rejectApp('Sublime Text')
        :rejectApp('Atom')
        :rejectApp('Finder')
        :rejectApp('Google Chrome')
        :rejectApp('Sublime Merge')
        :rejectApp('Notion')
        :rejectApp('Spotify')
        :rejectApp('Invoker')
        :rejectApp('Dash')
        :getWindows(hs.window.filter.sortByFocusedLast)

    Search.loadWindowsInAlfred(windows, 1)
end

hs.urlevent.bind('window-focus', function(eventName, params)
    hs.window(tonumber(params.id)):focus()
end)

return Search