local App = {}
App.__index = App

App.bundles = {
    anybox = 'cc.anybox.Anybox',
    arc = 'company.thebrowser.Browser',
    brave = 'com.brave.Browser',
    calendar = 'com.busymac.busycal-setapp',
    chrome = 'com.google.Chrome',
    dash = 'com.kapeli.dashdoc',
    discord = 'com.hnc.Discord',
    finder = 'com.apple.finder',
    gitfox = 'com.bytieful.Gitfox-setapp',
    gitkraken = 'com.axosoft.gitkraken',
    invoker = 'de.beyondco.invoker',
    iterm = 'com.googlecode.iterm2',
    mail = 'com.mimestream.Mimestream',
    obsidian = 'md.obsidian',
    pop = 'com.pop.pop.app',
    postman = 'com.postmanlabs.mac',
    preview = 'com.apple.Preview',
    rayapp = 'be.spatie.ray',
    sideNotes = 'com.apptorium.SideNotes-setapp',
    sigma = 'com.sigmaos.sigmaos.macos',
    slack = 'com.tinyspeck.slackmacgap',
    spotify = 'com.spotify.client',
    sublimeMerge = 'com.sublimemerge',
    tableplus = 'com.tinyapp.TablePlus-setapp',
    tinkerwell = 'de.beyondco.tinkerwell',
    transmit = 'com.panic.Transmit',
    vivaldi = 'com.vivaldi.Vivaldi',
    vscode = 'com.microsoft.VSCode',
    warp = 'dev.warp.Warp-Stable',
    windsurf = 'com.exafunction.windsurf',
    youtubeMusic = 'com.google.Chrome.app.cinhimbnkkaeohfgghhklpknlkffjgod',
    zen = 'app.zen-browser.zen',
    zoom = 'us.zoom.xos',
}

App.browsers = {
    App.bundles.arc,
    App.bundles.brave,
    App.bundles.chrome,
}

function App.codeEditor()
    return App.includes({vscode, tinkerwell, windsurf})
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
