local mdl = {}
mdl.__index = mdl

Modal.add({
    key = 'CodeSnippets:generalSnippets',
    title = 'General Snippets',
    items = {
        n = 'new ',
        m = function()
            Modal.exit()
            if is.lua() then
                ks.type('nil')
            else
                ks.type('null')
            end
        end,
        t = 'true',
        o = 'protected ',
        p = 'public ',
        f = 'false',
        v = 'private '
    },
    callback = function(item)
        Modal.exit()
        ks.type(item)
    end
})

return mdl
