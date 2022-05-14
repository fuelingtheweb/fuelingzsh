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
    },
    callback = function(item)
        Modal.exit()
        ks.type(item)
    end
})

return mdl
