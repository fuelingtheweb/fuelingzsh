local CaseDialog = {}
CaseDialog.__index = CaseDialog

CaseDialog.lookup = {
    y = 'upperFirst',
    u = 'upper',
    i = 'kebab',
    o = 'constant',
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
        fn.Alfred.run(
            'case-dialog',
            'com.fuelingtheweb.commands',
            CaseDialog.lookup[key]
        )
    end
end

hs.urlevent.bind('case-changeFromAlfred', function(eventName, params)
    result = str.trim(hs.execute('~/.nvm/versions/node/v12.4.0/bin/node ~/Dev/Anvil/bin/change-case/bin/index.js "' .. params.to .. '" "' .. params.text .. '"'))
    fn.clipboard.set(result)
    ks.type(result)
end)

return CaseDialog
