local CaseMode = {}
CaseMode.__index = CaseMode

CaseMode.lookup = {
    y = 'to=upperFirst&key=y',
    u = 'to=upper&key=u',
    i = 'to=constant&key=i',
    o = 'to=kebab&key=o',
    p = 'to=pascal&key=p',
    h = 'to=title&key=h',
    j = 'to=sentence&key=j',
    k = 'to=snake&key=k',
    l = 'to=lower&key=l',
    m = 'to=camel&key=m',
    period = 'to=dot&key=.',
    slash = 'to=path&key=/',
}

function CaseMode.handle(key)
    if CaseMode.lookup[key] then
        hs.execute("open -g 'hammerspoon://case-change?" .. CaseMode.lookup[key] .. "'")
    end
end

hs.urlevent.bind('case-change', function(eventName, params)
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 'c', 0)
        hs.eventtap.keyStroke({'ctrl', 'alt'}, params.key, 0)
    else
        text = getSelectedText()

        if not text then
            hs.eventtap.keyStroke({'shift', 'alt'}, 'left', 0)
            text = getSelectedText()
        end

        result = trim(hs.execute('/Users/nathan/.nvm/versions/node/v12.4.0/bin/node /Users/nathan/.fuelingzsh/bin/change-case/bin/index.js "' .. params.to .. '" "' .. text .. '"'))
        hs.eventtap.keyStrokes(result)
    end
end)

return CaseMode
