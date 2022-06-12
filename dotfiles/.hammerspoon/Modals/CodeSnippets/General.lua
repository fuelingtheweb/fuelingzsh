local mdl = {}
mdl.__index = mdl

Modal.add({
    key = 'CodeSnippets:generalSnippets',
    title = 'General Snippets',
    items = {
        n = 'new ',
        m = function()
            Modal.exit()
            cm.Code.null()
        end,
        t = 'true',
        o = 'protected ',
        p = 'public ',
        f = 'false',
        v = 'private ',
        [';'] = function()
            Modal.exit()
            md.Code.comment()
            ks.type('NTM: ')
        end,
        ["'"] = function()
            Modal.exit()
            md.Code.comment()
            ks.type('TODO: ')
        end,
        e = function()
            Modal.exit()

            if is.blade() then
                ks.type('@endif')
            elseif is.php() or is.js() then
                ks.type('}')
            elseif is.lua() then
                ks.type('end')
            end
        end,
        i = function()
            Modal.exit()

            if is.blade() then
                ks.type('@elseif ()').left()
            elseif is.php() then
                ks.type('} elseif () {').left().left().left()
            elseif is.js() then
                ks.type('} else if () {').left().left().left()
            elseif is.lua() then
                ks.type('elseif  then').left().left().left().left().left()
            end
        end,
    },
    callback = function(item)
        Modal.exit()
        ks.type(item)
    end
})

return mdl
