local Alfred = {}
Alfred.__index = Alfred

function Alfred.open()
    ks.alt('z')
end

function Alfred.sleep()
    Alfred.search('cmd:sleep')
    ks.enter()
end

function Alfred.emptyTrash()
    Alfred.search('cmd:emptytrash')
    ks.enter()
end

function Alfred.search(search)
    hs.osascript.applescript('tell application id "com.runningwithcrayons.Alfred" to search "' .. search .. '"')
end

function Alfred.run(trigger, workflow, argument)
    spoon.KarabinerHandler.modifier = nil

    local script = 'tell application id "com.runningwithcrayons.Alfred" to run trigger "' .. trigger .. '" in workflow "' .. workflow .. '"'

    if argument then
        script = script .. ' with argument "' .. argument .. '"'
    end

    hs.osascript.applescript(script)
end

function Alfred.visible()
    return hs.application.find('com.runningwithcrayons.Alfred'):isFrontmost()
end

return Alfred
