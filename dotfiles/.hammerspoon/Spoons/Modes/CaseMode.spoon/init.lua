local CaseMode = {}
CaseMode.__index = CaseMode

CaseMode.lookup = {
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
    period = {to = 'dot', key = '.'},
    slash = {to = 'path', key = '/'},
}

function CaseMode.handle(key)
    local item = CaseMode.lookup[key]

    if type(item) == 'table' then
        CaseMode.change(item.to, item.key)
    else
        CaseMode.change(item, key)
    end
end

function CaseMode.change(to, key)
    if TextManipulation.canManipulateWithVim() then
        fastKeyStroke({'ctrl', 'alt', 'cmd'}, 'c')
        fastKeyStroke({'ctrl', 'alt'}, key)
    else
        text = getSelectedText()

        if not text then
            fastKeyStroke({'shift', 'alt'}, 'left')
            text = getSelectedText()
        end

        result = trim(hs.execute('/Users/nathan/.nvm/versions/node/v12.4.0/bin/node /Users/nathan/.fuelingzsh/bin/change-case/bin/index.js "' .. to .. '" "' .. text .. '"'))
        insertText(result)
    end
end

return CaseMode
