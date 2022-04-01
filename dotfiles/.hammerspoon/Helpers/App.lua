local App = {}
App.__index = App

App.bundles = {
    atom = 'com.github.atom',
    chrome = 'com.google.Chrome',
    discord = 'com.hnc.Discord',
    finder = 'com.apple.finder',
    invoker = 'de.beyondco.invoker',
    iterm = 'com.googlecode.iterm2',
    notion = 'notion.id',
    postman = 'com.postmanlabs.mac',
    preview = 'com.apple.Preview',
    rayapp = 'be.spatie.ray',
    slack = 'com.tinyspeck.slackmacgap',
    spotify = 'com.spotify.client',
    sublime = 'com.sublimetext.4',
    sublimeMerge = 'com.sublimemerge',
    tableplus = 'com.tinyapp.TablePlus',
    teams = 'com.microsoft.teams',
    transmit = 'com.panic.Transmit',
    vscode = 'com.microsoft.VSCode',
    zoom = 'us.zoom.xos',
}

function App.codeEditor()
    return App.includes({atom, sublime, vscode})
end

function App.is(bundle)
    return hs.application.frontmostApplication():bundleID() == bundle
end

function App.includes(bundles)
    return hasValue(bundles, hs.application.frontmostApplication():bundleID())
end

function App.loadBundleVariables()
    each(App.bundles, function(bundle, key)
        _G[key] = bundle
    end)
end

return App
