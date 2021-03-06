local SearchMode = {}
SearchMode.__index = SearchMode

function SearchMode.tab()
end

function SearchMode.q()
end

function SearchMode.w()
    SearchMode.windowsInCurrentApp()
end

function SearchMode.e()
end

function SearchMode.r()
end

function SearchMode.t()
    SearchMode.tabs()
end

function SearchMode.caps_lock()
    SearchMode.default()
end

function SearchMode.a()
    SearchMode.allWindows()
end

function SearchMode.s()
    -- Search for Symbol
    fastKeyStroke({'cmd'}, 'r')
end

function SearchMode.d()
end

function SearchMode.f()
    -- Search files
    triggerAlfredSearch('open ')
end

function SearchMode.g()
    triggerAlfredWorkflow('google', 'com.akikoz.alfred.websearchsuggest')
end

function SearchMode.left_shift()
end

function SearchMode.z()
    triggerAlfredWorkflow('amazon', 'com.akikoz.alfred.websearchsuggest')
end

function SearchMode.x()
end

function SearchMode.c()
    -- Search for merge conflicts
    fastKeyStroke('/')
    insertText('<<<<<')
    fastKeyStroke('return')
end

function SearchMode.v()
end

function SearchMode.b()
end

function SearchMode.spacebar()
end

function SearchMode.default()
    if inCodeEditor() then
        TextManipulation.disableVim()
        fastKeyStroke('/')
    end
end

function SearchMode.tabs()
    if appIs(atom) then
        fastKeyStroke({'cmd'}, 'b')
    elseif appIs(sublime) then
        fastKeyStroke({'alt', 'shift'}, 'p')
    elseif appIs(chrome) then
        fastKeyStroke({'shift'}, 't')
    end
end

function SearchMode.windowsInCurrentApp()
    windows = hs.window.filter.new({hs.application.frontmostApplication():name()}):getWindows(hs.window.filter.sortByFocusedLast)

    SearchMode.loadWindowsInAlfred(windows, 2)
end

function SearchMode.loadWindowsInAlfred(windows, minimum)
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

function SearchMode.allWindows()
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

    SearchMode.loadWindowsInAlfred(windows, 1)
end

hs.urlevent.bind('window-focus', function(eventName, params)
    hs.window(tonumber(params.id)):focus()
end)

return SearchMode
