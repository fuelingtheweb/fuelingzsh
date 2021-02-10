local obj = {}
obj.__index = obj

function isDisplay(name)
    return hs.screen.primaryScreen():name() == name
end

function isMacbookDisplay()
    return isDisplay(macbookScreen)
end

function appIncludes(bundles)
    return has_value(bundles, hs.application.frontmostApplication():bundleID())
end

function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
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

function copyChromeUrl()
    hs.osascript.applescript([[
        tell application "Google Chrome"
            set theUrl to URL of active tab of front window
        end tell

        set the clipboard to theUrl
    ]])
end

function startsWith(needle, haystack)
    return haystack:sub(1, #needle) == needle
end

function titleContains(needle)
    return stringContains(needle:gsub('-', '%%-'), currentTitle())
end

function stringContains(needle, haystack)
    return string.find(haystack, needle)
end

function showChooser(callback, choices)
    hs.chooser.new(function(item)
        callback(item['subText'])
    end):choices(choices):show()
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

function openInChrome(url)
    hs.execute('"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" "' .. url .. '" --profile-directory="Default"')
end

function openInChromeIncognito(url)
    hs.execute('"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" "' .. url .. '" --incognito --profile-directory="Default"')
end

function openInTablePlus(url)
    hs.execute('open "' .. url .. '"')
end

function openInIterm(path)
    launchIterm(function()
        hs.execute('open -a iTerm "' .. path .. '"')
    end)
end

function runGoogleSearch(query)
    openInChromeIncognito(getUrlForQuery(query))
end

function getUrlForQuery(query)
    if startsWith('http', query) then
        return query
    end

    return 'https://www.google.com/search?q=' .. query
end

function triggerInAtom(name)
    hs.eventtap.keyStroke({'shift', 'cmd'}, 'P')
    hs.eventtap.keyStrokes(name)
    hs.timer.doAfter(0.3, function()
        hs.eventtap.keyStroke({}, 'return')
    end)
end

function goToFileInAtom(file)
    hs.eventtap.keyStroke({'cmd'}, 'T')
    hs.eventtap.keyStrokes(file)
    hs.timer.doAfter(0.3, function()
        hs.eventtap.keyStroke({}, 'return')
    end)
end

function typeAndEnter(string)
    hs.eventtap.keyStrokes(string)
    hs.eventtap.keyStroke({}, 'return')
end

function typeAndTab(string)
    hs.eventtap.keyStrokes(string)
    hs.eventtap.keyStroke({}, 'tab')
end

function triggerAlfredSearch(search)
    hs.osascript.applescript('tell application id "com.runningwithcrayons.Alfred" to search "' .. search ..' "')
end

function triggerAlfredWorkflow(trigger, workflow, argument)
    local script = 'tell application id "com.runningwithcrayons.Alfred" to run trigger "' .. trigger .. '" in workflow "' .. workflow .. '"'

    if argument then
        script = script .. ' with argument "' .. argument .. '"'
    end

    hs.osascript.applescript(script)
end

function openInAtom(path)
    hs.execute('/usr/local/bin/atom "' .. path .. '"')
end

function currentTitle()
    app = hs.application.frontmostApplication()

    title = ''
    for k,v in pairs(app:visibleWindows()) do
        if title == '' then
            title = v:title()
        end
    end

    return title
end

function windowCount(app)
    if app == nil then
        return 0
    end

    count = 0
    for k,v in pairs(app:visibleWindows()) do
        if (appIs(preview) or appIs(finder)) and v:title() == '' then
        else
            count = count + 1
        end
    end

    return count
end

function countTable(table)
    if not table then
        return 0
    end

    local count = 0
    each(table, function ()
        count = count + 1
    end)

    return count
end

function hasWindows(app)
    return windowCount(app) > 0
end

function multipleWindows(app)
    return windowCount(app) > 1
end

function toggleAppStatic()
    output = hs.execute('/Users/nathan/Development/FuelingTheWeb/bin/toggle-app-static.sh')
    hs.notify.new({title = 'Env Variable Updated', informativeText = output}):send()
end

-- openInAppFunctions = {
--     atom = 'openInAtom',
--     chrome = 'openInChrome',
--     tableplus = 'openInTablePlus',
--     iterm = 'openInIterm',
--     parent = 'openParentProject',
-- }

-- function triggerOpenProject(site)
    -- if not project['all'] then
    --     return
    -- end

    -- for key, value in pairs(openInAppFunctions) do
    --     app = key
    --     func = value

    --     if project[app] and has_value(project['all'], app) then
    --         if type(project[app]) == 'function' then
    --             project[app]()
    --         elseif type(project[app]) == 'table' then
    --             for key, value in pairs(project[app]) do
    --                 _G[func](value)
    --             end
    --         else
    --             _G[func](project[app])
    --         end
    --     end
    -- end
-- end

-- function openParentProject(parent)
--     if projects[parent]['open']['all'] then
--         triggerOpenProject(projects[parent]['open'])
--     end
-- end

function customOpenInTablePlus()
    if not ProjectManager:openDatabaseForCurrent() then
        triggerAlfredWorkflow('tableplus', 'com.chrisrenga.tableplus')
    end
end

function each(table, callback)
    for key, value in pairs(table) do
        callback(value, key)
    end
end

function executeFromFuelingZsh(command)
    return hs.execute('~/.fuelingzsh/bin/' .. command)
end

function trim(s)
    return (s:gsub("^%s*(.-)%s*$", "%1"))
end

return obj
