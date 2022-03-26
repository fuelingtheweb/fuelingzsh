local obj = {}
obj.__index = obj

function isDisplay(name) return hs.screen.primaryScreen():name() == name end

function isMacbookDisplay() return isDisplay(macbookScreen) end

function inCodeEditor() return appIncludes({atom, sublime, vscode}) end

function appIncludes(bundles)
    return hasValue(bundles, hs.application.frontmostApplication():bundleID())
end

function hasValue(tab, val)
    for index, value in ipairs(tab) do if value == val then return true end end

    return false
end

function isString(value) return type(value) == 'string' end

function isTable(value) return type(value) == 'table' end

function isFunction(value) return type(value) == 'function' end

function appIs(bundle)
    return hs.application.frontmostApplication():bundleID() == bundle
end

function isAlfredVisible()
    return hs.application.find('com.runningwithcrayons.Alfred'):isFrontmost()
end

function getSelectedText(copying)
    original = hs.pasteboard.getContents()
    hs.pasteboard.clearContents()

    if appIs(vscode) then
        ks.slow().shiftAltCmd('c')
    else
        ks.slow().copy()
    end

    text = hs.pasteboard.getContents()
    finderFileSelected = false
    for k, v in pairs(hs.pasteboard.contentTypes()) do
        if v == 'public.file-url' then finderFileSelected = true end
    end

    if not copying then
        hs.pasteboard.setContents(original)

        if finderFileSelected then text = nil end
    end

    return text
end

function currentUrl()
    original = hs.pasteboard.getContents()
    hs.pasteboard.clearContents()

    copyChromeUrl()
    url = hs.pasteboard.getContents()

    hs.pasteboard.setContents(original)

    return url
end

function copyChromeUrl()
    hs.osascript.applescript([[
        tell application "Google Chrome"
            set theUrl to URL of active tab of front window
        end tell

        set the clipboard to theUrl
    ]])
end

function startsWith(needle, haystack) return haystack:sub(1, #needle) == needle end

function titleContains(needle)
    return stringContains(needle:gsub('-', '%%-'), currentTitle())
end

function urlContains(needle)
    return stringContains(needle:gsub('-', '%%-'), currentUrl())
end

function stringContains(needle, haystack) return string.find(haystack, needle) end

function showChooser(callback, choices)
    hs.chooser.new(function(item) callback(item['subText']) end):choices(choices)
        :show()
end

function openDiscordChannel(name)
    ks.slow().cmd('k')
    ks.type(name)
    hs.timer.doAfter(0.1, ks.enter)
end

function openSlackChannel(channel)
    hs.urlevent.openURL('slack://channel?' .. channel)
end

function openNotionPage(name)
    ks.slow().cmd('p')
    ks.type(name)
    hs.timer.doAfter(0.3, ks.enter)
end

function maximizeAfterDelay()
    hs.timer.doAfter(0.5, function() md.WindowManager.moveTo('maximize') end)
end

function openInChrome(url)
    hs.execute(
        '"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" "' ..
            url .. '" --profile-directory="Default"')
    maximizeAfterDelay()
end

function openInChromeIncognito(url)
    hs.execute(
        '"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" "' ..
            url .. '" --incognito --profile-directory="Default"')
    maximizeAfterDelay()
end

function openInTablePlus(url) hs.execute('open "' .. url .. '"') end

function openInIterm(path)
    launchIterm(function() hs.execute('open -a iTerm "' .. path .. '"') end)
end

function runGoogleSearch(query) openInChromeIncognito(getUrlForQuery(query)) end

function getUrlForQuery(query)
    if startsWith('http', query) then return query end

    return 'https://www.google.com/search?q=' .. query
end

function triggerInAtom(name)
    ks.slow().shiftCmd('p')
    ks.type(name)
    hs.timer.doAfter(0.3, ks.enter)
end

function triggerInCode(name)
    ks.slow().shiftCmd('p')
    ks.type(name)
    hs.timer.doAfter(0.3, ks.enter)
end

function goToFileInAtom(file)
    ks.slow().cmd('t')
    ks.type(file)
    hs.timer.doAfter(0.3, ks.enter)
end

function typeAndEnter(string) ks.type(string).enter() end

function triggerAlfredSearch(search)
    hs.osascript.applescript(
        'tell application id "com.runningwithcrayons.Alfred" to search "' ..
            search .. '"')
end

function triggerAlfredWorkflow(trigger, workflow, argument)
    spoon.KarabinerHandler.modifier = nil

    local script =
        'tell application id "com.runningwithcrayons.Alfred" to run trigger "' ..
            trigger .. '" in workflow "' .. workflow .. '"'

    if argument then script = script .. ' with argument "' .. argument .. '"' end

    hs.osascript.applescript(script)
end

function openInSublime(path)
    hs.execute('/usr/local/bin/subl "' .. path .. '"')
    maximizeAfterDelay()
end

function openInAtom(path)
    hs.execute('/usr/local/bin/atom "' .. path .. '"')
    maximizeAfterDelay()
end

function openInCode(path)
    hs.execute('/usr/local/bin/code "' .. path:gsub('~', '/Users/nathan') .. '"')
    maximizeAfterDelay()
end

function currentTitle()
    app = hs.application.frontmostApplication()

    title = ''
    for k, v in pairs(app:visibleWindows()) do
        if title == '' then title = v:title() end
    end

    return title
end

function windowCount(app)
    if app == nil then return 0 end

    count = 0
    for k, v in pairs(app:visibleWindows()) do
        if (appIs(preview) or appIs(finder)) and v:title() == '' then
        else
            count = count + 1
        end
    end

    return count
end

function countTable(table)
    if not table then return 0 end

    local count = 0
    each(table, function() count = count + 1 end)

    return count
end

function hasWindows(app) return windowCount(app) > 0 end

function multipleWindows(app) return windowCount(app) > 1 end

function toggleAppStatic()
    output = hs.execute(
                 '/Users/nathan/Development/FuelingTheWeb/bin/toggle-app-static.sh')
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

--     if project[app] and hasValue(project['all'], app) then
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
    for key, value in pairs(table) do callback(value, key) end
end

function executeFromFuelingZsh(command)
    return hs.execute('~/.fuelingzsh/bin/' .. command)
end

function trim(s) return (s:gsub("^%s*(.-)%s*$", "%1")) end

function closeWindow()
    ks.close()
    if appIs(chrome) then
        hs.timer.doAfter(1, function()
            app = hs.application.frontmostApplication()
            if next(app:visibleWindows()) == nil then app:hide() end
        end)
    end
end

function updateChromeUrl(needle, newUrl)
    copyChromeUrl()

    if stringContains(needle, hs.pasteboard.getContents()) then
        hs.osascript.applescript([[
            tell application "Google Chrome"
                set URL of active tab of front window to "]] .. newUrl .. [["
            end tell
        ]])

        return true
    end
end

function slackReaction(emoji)
    ks.slow().key('r')

    if emoji then
        ks.type(emoji)
        hs.timer.doAfter(0.5, function() ks.slow().enter() end)
    end
end

function handleApp(callback, lookup)
    local bundle = hs.application.frontmostApplication():bundleID()

    if isTable(callback) then
        lookup = callback
        callback = nil
    end

    if lookup[bundle] then
        if callback then
            callback(table.unpack(lookup[bundle]))
        else
            lookup[bundle]()
        end
    end
end

function handleConditional(conditional, callback, lookup)
    if isTable(callback) then
        lookup = callback
        callback = nil
    end

    for key, value in pairs(lookup) do
        if conditional(value.condition) or value.condition == 'fallback' then
            if callback then
                if isTable(value.value) then
                    callback(table.unpack(value.value))
                else
                    callback(value.value)
                end
            else
                value()
            end

            return
        end
    end
end

function _(callback, ...)
    local params = table.pack(...)

    return function() callback(table.unpack(params)) end
end

function loadCustomModal(modal) return require('config.custom.Modals.' .. modal) end

function loadModal(modal) return require('Modals.' .. modal) end

function isLua() return titleContains('.lua') end

return obj
