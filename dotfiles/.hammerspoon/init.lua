apps = {}
atom = 'com.github.atom'
chrome = 'com.google.Chrome'
discord = 'com.hnc.Discord'
finder = 'com.apple.finder'
iterm = 'com.googlecode.iterm2'
notion = 'notion.id'
preview = 'com.apple.Preview'
spotify = 'com.spotify.client'
sublime = 'com.sublimetext.3'
sublimeMerge = 'com.sublimemerge'
tableplus = 'com.tinyapp.TablePlus'
teams = 'com.microsoft.teams'
apps['atom'] = atom
apps['chrome'] = chrome
apps['finder'] = finder
apps['sublime'] = sublime

ultrawide = 'LG ULTRAWIDE'
macbookScreen = 'Color LCD'

function isDisplay(name)
    return hs.screen.primaryScreen():name() == name
end

function isMacbookDisplay()
    return isDisplay(macbookScreen)
end

function appIs(bundle)
    return hs.application.frontmostApplication():bundleID() == bundle
end

function getSelectedText(copying)
    original = hs.pasteboard.getContents()
    hs.pasteboard.clearContents()
    hs.eventtap.keyStroke({'cmd'}, 'C')
    text = hs.pasteboard.getContents()
    finderFileSelected = false
    for k,v in pairs(hs.pasteboard.contentTypes()) do
        if v == 'public.file-url' then
            finderFileSelected = true
        end
    end

    if not copying and finderFileSelected then
        text = 'finderFileSelected'
    end

    if not copying then
        hs.pasteboard.setContents(original)
    end

    return text
end

function startsWith(needle, haystack)
    return haystack:sub(1, #needle) == needle
end

function openDiscordChannel(name)
    hs.eventtap.keyStroke({'cmd'}, 'K')
    hs.eventtap.keyStrokes(name)
    hs.timer.doAfter(0.1, function()
        hs.eventtap.keyStroke({}, 'return')
    end)
end

function openNotionPage(name)
    hs.eventtap.keyStroke({'cmd'}, 'P')
    hs.eventtap.keyStrokes(name)
    hs.timer.doAfter(0.3, function()
        hs.eventtap.keyStroke({}, 'return')
    end)
end

hs.hotkey.bind({'cmd', 'alt', 'ctrl'}, 'B', function()
    app = hs.application.frontmostApplication()
    bundle = app:bundleID()
    hs.pasteboard.setContents(bundle)
    hs.notify.new({title = 'App Bundle Copied', informativeText = bundle}):send()
end)

hs.screen.watcher.new(function()
    if isDisplay(ultrawide) then
        hs.audiodevice.findOutputByName('Built-in Output'):setDefaultOutputDevice()
    end
end):start()

wf = hs.window.filter
windowsForCreatedHook = wf.new{'Sublime Text', 'Notion', 'Atom', 'Google Chrome', 'Discord', 'Microsoft Teams', 'Finder'}
allwindows = wf.new(nil)
allwindows:rejectApp('Hammerspoon'):rejectApp('Alfred'):rejectApp('Shortcat')
windowsForCreatedHook:subscribe(wf.windowCreated, function ()
    if appIs(sublime) or appIs(notion) or appIs(atom) or appIs(chrome) then
        hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 'F')
    elseif appIs(discord) then
        hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 'H')
    elseif appIs(teams) then
        if isMacbookDisplay() then
            hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 'F')
        else
            hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 'L')
        end
    elseif appIs(finder) then
        hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 'J')
    end
end)
-- logger = hs.logger.new('ftw', 'debug')
allwindows:subscribe(wf.windowDestroyed, function (window, appName, reason)
    app = hs.application.frontmostApplication()
    count = 0
    for k,v in pairs(app:visibleWindows()) do
        if (appIs(preview) or appIs(finder)) and v:title() == '' then
        else
            count = count + 1
        end
    end
    if count < 1 then
        if appIs(preview) then
            app:kill()
        else
            app:hide()
        end
    end
end)
hs.urlevent.bind('closeWindow', function()
    hs.eventtap.keyStroke({'cmd'}, 'W')
    if appIs(chrome) then
        hs.timer.doAfter(1, function()
            app = hs.application.frontmostApplication()
            if next(app:visibleWindows()) == nil then
                app:hide()
            end
        end)
    end
end)

gokuWatcher = hs.pathwatcher.new(os.getenv('HOME') .. '/.config/karabiner.edn/', function ()
    output = hs.execute('/usr/local/bin/goku')
    hs.notify.new({title = 'Karabiner Config', informativeText = output}):send()
end):start()

hs.urlevent.bind('scrollInNotion', function()
    if appIs(notion) then
        hs.eventtap.keyStroke({}, 'down')
        hs.eventtap.keyStroke({}, 'return')
        hs.eventtap.keyStroke({}, 'delete')
        hs.eventtap.keyStroke({}, 'pagedown')
    end
end)

hs.urlevent.bind('!Cj', function()
    if appIs(iterm) then
        -- iTerm: Autocomplete next word
        hs.eventtap.keyStroke({'shift', 'alt', 'cmd'}, 'J')
    elseif appIs(atom) or appIs(sublime) then
        -- Atom, Sublime: Move line down
        hs.eventtap.keyStroke({'ctrl', 'cmd'}, 'Down')
    elseif appIs(teams) then
        -- Teams: Move to next conversation
        hs.eventtap.keyStroke({'alt'}, 'Down')
    end
end)

hs.urlevent.bind('!Ck', function()
    if appIs(atom) or appIs(sublime) then
        -- Atom, Sublime: Move line up
        hs.eventtap.keyStroke({'ctrl', 'cmd'}, 'Up')
    elseif appIs(teams) then
        -- Teams: Move to previous conversation
        hs.eventtap.keyStroke({'alt'}, 'Up')
    end
end)

hs.urlevent.bind('hyperH', function()
    if appIs(spotify) then
        hs.eventtap.keyStroke({'alt', 'cmd'}, 'Left')
    elseif appIs(discord) then
        hs.eventtap.keyStroke({'cmd'}, 'K')
        hs.eventtap.keyStroke({}, 'return')
    else
        hs.eventtap.keyStroke({'cmd'}, '[')
    end
end)

hs.urlevent.bind('hyperL', function()
    if appIs(spotify) then
        hs.eventtap.keyStroke({'alt', 'cmd'}, 'Right')
    elseif appIs(iterm) then
        -- Autocomplete to the end of the line
        hs.eventtap.keyStroke({'cmd'}, 'L')
    else
        hs.eventtap.keyStroke({'cmd'}, ']')
    end
end)

hs.urlevent.bind('done', function()
    if appIs(notion) then
        hs.eventtap.keyStroke({'cmd'}, 'return')
    elseif appIs(sublime) then
        -- Edit with: Done
        hs.eventtap.keyStroke({'shift', 'ctrl', 'alt', 'cmd'}, 'd')
    else
        hs.eventtap.keyStroke({'cmd'}, 'return')
    end
end)

hs.urlevent.bind('save', function()
    if appIs(chrome) then
        -- Save to Raindrop
        hs.eventtap.keyStroke({'shift', 'cmd'}, 's')
    elseif appIs(iterm) then
        -- Save from Vim
        hs.eventtap.keyStroke({'shift'}, ';')
        hs.eventtap.keyStroke({}, 'x')
        hs.eventtap.keyStroke({}, 'return')
    else
        hs.eventtap.keyStroke({'cmd'}, 's')
    end
end)

hs.urlevent.bind('newTab', function()
    if appIs(sublime) or appIs(atom) then
        hs.eventtap.keyStroke({'cmd'}, 'n')
    else
        hs.eventtap.keyStroke({'cmd'}, 't')
    end
end)

hs.urlevent.bind('previousTab', function()
    if appIs(tableplus) then
        hs.eventtap.keyStroke({'cmd'}, '[')
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, '[')
    end
end)

hs.urlevent.bind('nextTab', function()
    if appIs(tableplus) then
        hs.eventtap.keyStroke({'cmd'}, ']')
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, ']')
    end
end)

hs.urlevent.bind('openAnything', function()
    if appIs(notion) or appIs(atom) or appIs(sublime) or appIs(sublimeMerge) or appIs(tableplus) then
        hs.eventtap.keyStroke({'cmd'}, 'p')
    elseif appIs(finder) then
        hs.osascript.applescript('tell application id "com.runningwithcrayons.Alfred" to search "open "')
    elseif appIs(discord) then
        hs.eventtap.keyStroke({'cmd'}, 'k')
    elseif appIs(spotify) then
        hs.osascript.applescript('tell application id "com.runningwithcrayons.Alfred" to run trigger ".spot_mini" in workflow "com.vdesabou.spotify.mini.player"')
    elseif appIs(teams) then
        hs.eventtap.keyStroke({'cmd'}, 'e')
    elseif appIs(chrome) then
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'p')
    end
end)

hs.urlevent.bind('commandPalette', function()
    if appIs(atom) or appIs(sublime) or appIs(sublimeMerge) then
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'p')
    else
        hs.osascript.applescript('tell application id "com.runningwithcrayons.Alfred" to run trigger "search" in workflow "com.tedwise.menubarsearch"')
    end
end)

hs.urlevent.bind('cancelOrDelete', function()
    text = getSelectedText()
    if appIs(finder) and text == 'finderFileSelected' then
        hs.eventtap.keyStroke({'cmd'}, 'delete')
    elseif text then
        hs.eventtap.keyStroke({}, 'delete')
    elseif appIs(iterm) then
        hs.eventtap.keyStroke({'ctrl'}, 'C')
    elseif appIs(atom) then
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'delete')
    else
        hs.eventtap.keyStroke({}, 'delete')
    end
end)

hs.urlevent.bind('hyperY', function()
    text = getSelectedText(true)
    if text then
        -- Already in clipboard, do not reset
    elseif appIs(spotify) then
        hs.osascript.applescript([[
            tell application "Spotify"
                set theTrack to name of the current track
                set theArtist to artist of the current track
                set theAlbum to album of the current track
                set track_id to id of current track
            end tell

            set AppleScript's text item delimiters to ":"
            set track_id to third text item of track_id
            set AppleScript's text item delimiters to {""}
            set realurl to ("https://open.spotify.com/track/" & track_id)

            set theString to theTrack & " by " & theArtist & ": " & realurl
            set the clipboard to theString
        ]])
    elseif appIs(chrome) then
        hs.eventtap.keyStrokes('yy')
    end
end)

hs.urlevent.bind('dismissNotifications', function()
    hs.osascript.applescript([[
        tell application "System Events"
            tell process "Notification Center"
                set theseWindows to every window whose subrole is "AXNotificationCenterAlert" or subrole is "AXNotificationCenterBanner"
                repeat with i from 1 to number of items in theseWindows
                    set this_item to item i of theseWindows
                    try
                        click button 1 of this_item
                    end try
                end repeat
            end tell
        end tell
    ]])
end)

hs.urlevent.bind('copyTextArea', function()
    hs.eventtap.keyStroke({'shift', 'cmd'}, 'Up')
    hs.eventtap.keyStroke({'cmd'}, 'C')
    hs.eventtap.keyStroke({}, 'Right')
end)

hs.urlevent.bind('codeModeI', function()
    if appIs(atom) then
        -- Dev Tools: Console
        hs.eventtap.keyStroke({'shift', 'alt'}, 'I')
    elseif appIs(chrome) then
         -- Atom: Cursor History: Previous
        hs.eventtap.keyStroke({'alt', 'cmd'}, 'I')
    end
end)

hs.urlevent.bind('appModeT', function()
    if appIs(notion) then
        openNotionPage('tasks')
    end
end)

hs.urlevent.bind('appModeD', function()
    if appIs(notion) then
        openNotionPage('home')
    end
end)

hs.urlevent.bind('appModeS', function()
    if appIs(discord) then
        openDiscordChannel('swift-bunny')
    elseif appIs(notion) then
        openNotionPage('swift bunny')
    end
end)

hs.urlevent.bind('appModeA', function()
    if appIs(discord) then
        openDiscordChannel('shattered-plains')
    elseif appIs(notion) then
        openNotionPage('discuss with andrew')
    end
end)

hs.urlevent.bind('appModeC', function()
    if appIs(discord) then
        openDiscordChannel('palantí')
    elseif appIs(notion) then
        openNotionPage('discuss with chris')
    end
end)

hs.urlevent.bind('appModeH', function()
    if appIs(notion) then
        openNotionPage('hobbies + tasks')
    end
end)

function windowCount(app)
    count = 0
    for k,v in pairs(app:visibleWindows()) do
        if (appIs(preview) or appIs(finder)) and v:title() == '' then
        else
            count = count + 1
        end
    end

    return count
end

function hasWindows(app)
    return windowCount(app) > 0
end

function multipleWindows(app)
    return windowCount(app) > 1
end

hs.urlevent.bind('app', function(eventName, params)
    bundle = apps[params.id]
    app = hs.application.frontmostApplication()
    isActive = app:bundleID() == bundle

    if not isActive and not hasWindows(hs.application.get(bundle)) then
        hs.application.open(bundle)
    elseif not isActive then
        hs.application.get(bundle):activate()
    elseif multipleWindows(app) then
        hs.eventtap.keyStroke({'ctrl'}, 'tab')
    elseif not hasWindows(app) then
        hs.application.open(bundle)
    end
end)

hs.urlevent.bind('shortcat', function()
    bundle = 'com.sproutcube.Shortcat'

    if hs.application.get(bundle) == nil then
        hs.application.open(bundle)
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'space')
    end
end)

-- hs.urlevent.bind('deleteEverywhere', function()
--     if appIs(finder) then
--         hs.eventtap.keyStroke({'cmd'}, 'delete')
--     elseif appIs(atom) then
--         hs.eventtap.keyStroke({'shift', 'cmd'}, 'delete')
--     else
--         hs.eventtap.keyStroke({}, 'delete')
--     end
-- end)

-- hs.urlevent.bind('quote-spacebar', function(eventName, params)
--     app = hs.application.frontmostApplication()
--     bundle = app:bundleID()
--     if appIs(sublime) then
--         hs.eventtap.keyStrokes(' = ')
--     elseif appIs(notion) then
--         hs.eventtap.keyStrokes(' + ')
--     else
--         hs.eventtap.keyStrokes(' 9 ')
--     end
-- end)

hs.loadSpoon('MouseCircle')
spoon.MouseCircle.color = {hex = '#367f71'}
spoon.MouseCircle:bindHotkeys({show = {{'ctrl', 'alt', 'cmd'}, 'M'}})

hs.loadSpoon('ReloadConfiguration')
spoon.ReloadConfiguration:start()
hs.notify.new({title = 'Hammerspoon', informativeText = 'Config loaded'}):send()

if hs.application.get('com.manytricks.Moom') == nil then
    hs.execute('defaults import com.manytricks.Moom ~/.fuelingzsh/options/apps/moom/com.manytricks.Moom.plist')
    hs.application.launchOrFocusByBundleID('com.manytricks.Moom')
end
