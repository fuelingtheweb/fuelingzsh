local App = {}
App.__index = App

App.bundles = {
    chrome = 'com.google.Chrome',
    discord = 'com.hnc.Discord',
    finder = 'com.apple.finder',
    invoker = 'de.beyondco.invoker',
    iterm = 'com.googlecode.iterm2',
    postman = 'com.postmanlabs.mac',
    preview = 'com.apple.Preview',
    rayapp = 'be.spatie.ray',
    slack = 'com.tinyspeck.slackmacgap',
    spotify = 'com.spotify.client',
    sublimeMerge = 'com.sublimemerge',
    tableplus = 'com.tinyapp.TablePlus',
    tinkerwell = 'de.beyondco.tinkerwell',
    transmit = 'com.panic.Transmit',
    vscode = 'com.microsoft.VSCode',
    youtubeMusic = 'com.google.Chrome.app.cinhimbnkkaeohfgghhklpknlkffjgod',
    zoom = 'us.zoom.xos',
}

function App.codeEditor()
    return App.includes({vscode, tinkerwell})
end

function App.is(bundle)
    return hs.application.frontmostApplication():bundleID() == bundle
end

function App.includes(bundles)
    return fn.table.has(bundles, hs.application.frontmostApplication():bundleID())
end

function App.loadBundleVariables()
    fn.each(App.bundles, function(bundle, key)
        _G[key] = bundle
    end)
end

function App.hasWindows(app)
    return App.windowCount(app) > 0
end

function App.multipleWindows(app)
    return App.windowCount(app) > 1
end

function App.windowCount(app)
    if app == nil then return 0 end

    local count = 0

    for k, v in pairs(app:visibleWindows()) do
        if (is.In(preview) or is.finder()) and v:title() == '' then
        else
            count = count + 1
        end
    end

    return count
end

return App
