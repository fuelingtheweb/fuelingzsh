local Search = {}
Search.__index = Search

function Search.symbol()
    ks.cmd('r')
end

function Search.files()
    fn.Alfred.search('open ')
end

function Search.google()
    fn.Alfred.run('google', 'com.akikoz.alfred.websearchsuggest')
end

function Search.amazon()
    fn.Alfred.run('amazon', 'com.akikoz.alfred.websearchsuggest')
end

function Search.viaAlfred()
    fn.Alfred.search('search:')
end

function Search.default()
    if is.codeEditor() then
        TextManipulation.disableVim()
        ks.key('/')
    end
end

function Search.windowsInCurrentApp()
    windows = hs.window.filter
        .new({hs.application.frontmostApplication():name()})
        :getWindows(hs.window.filter.sortByFocusedLast)

    Search.loadWindowsInAlfred(windows, 2)
end

function Search.loadWindowsInAlfred(windows, minimum)
    if not windows or fn.table.count(windows) < minimum then
        return
    end

    local items = {}
    fn.each(windows, function(window)
        local app = window:application()
        local iconPath = '~/.fuelingzsh/custom/' .. app:name() .. '.png'
        hs.image.imageFromAppBundle(app:bundleID()):saveToFile(iconPath)
        table.insert(items, {
            uid = window:id(),
            title = window:title(),
            match = app:name() .. ' ' .. window:title(),
            arg = window:id(),
            icon = {path = iconPath},
        })
    end)

    hs.json.write({items = items}, '/Users/nathan/.fuelingzsh/custom/windows.json', false, true)

    fn.Alfred.run('windows', 'com.fuelingtheweb.commands')
end

function Search.allWindows()
    local windows = hs.window.filter.default:getWindows(hs.window.filter.sortByFocusedLast)

    Search.loadWindowsInAlfred(windows, 1)
end

function Search.window()
    if is.codeEditor() then
        ks.shiftCmd('f')
        TextManipulation.disableVim()
    else
        ks.cmd('f')
    end
end

function Search.tabs()
    if is.codeEditor() then
        ks.shiftAltCmd('tab')
        TextManipulation.disableVim()
    end
end

hs.urlevent.bind('window-focus', function(eventName, params)
    hs.window(tonumber(params.id)):focus()
end)

return Search
