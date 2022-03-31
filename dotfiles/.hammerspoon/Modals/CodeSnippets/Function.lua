local mdl = {}
mdl.__index = mdl

Modal.add({
    key = 'CodeSnippets:function',
    title = 'Snippet: Function',
    items = {
        n = {name = 'primary', method = 'primary'},
        v = {name = 'validation', method = 'validation'},
        s = {name = 'short', method = 'short'},
    },
    callback = function(item)
        Modal.exit()

        if item.method == 'primary' then
            md.CodeSnippets.snippet('function')
        else
            md.CodeSnippets.snippet('function-' .. item.method)
        end

        Brackets.start()
    end,
})

return mdl
