local CaseDialog = {}
CaseDialog.__index = CaseDialog

CaseDialog.lookup = {
    y = 'upperFirst',
    u = 'upper',
    i = 'constant',
    o = 'kebab',
    p = 'pascal',
    h = 'title',
    j = 'sentence',
    k = 'snake',
    l = 'lower',
    m = 'camel',
    period = 'dot',
    slash = 'path',
}

function CaseDialog.handle(key)
    if CaseDialog.lookup[key] then
        triggerAlfredWorkflow('case-dialog', 'com.fuelingtheweb.commands', CaseDialog.lookup[key])
    end
end

hs.urlevent.bind('case-changeFromAlfred', function(eventName, params)
    result = trim(hs.execute('/Users/nathan/.nvm/versions/node/v12.4.0/bin/node /Users/nathan/.fuelingzsh/bin/change-case/bin/index.js "' .. params.to .. '" "' .. params.text .. '"'))
    hs.pasteboard.setContents(result)
    hs.eventtap.keyStrokes(result)
end)

return CaseDialog
