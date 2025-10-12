local ChangeCase = {}
ChangeCase.__index = ChangeCase

ChangeCase.lookup = {
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

function ChangeCase.handle(key)
    local item = ChangeCase.lookup[key]

    if type(item) == 'table' then
        ChangeCase.change(item.to, item.key)
    else
        ChangeCase.change(item, key)
    end
end

function ChangeCase.change(to, key)
    if is.vimMode() then
        ks.super('c').ctrlAlt(key)

        if is.vscode() then
            ks.escape().key('a')
        end
    else
        local text = str.selected()

        if not text then
            ks.shiftAlt('left')
            text = str.selected()
        end

        result = str.trim(hs.execute('~/.nvm/versions/node/v12.4.0/bin/node ~/.fuelingzsh/bin/change-case/bin/index.js "' .. to .. '" "' .. text .. '"')):gsub('~', home_path)
        ks.type(result)
    end
end

return ChangeCase
