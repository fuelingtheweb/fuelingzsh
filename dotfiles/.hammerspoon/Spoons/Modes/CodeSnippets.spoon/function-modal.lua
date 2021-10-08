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
            spoon.CodeSnippets.snippet('function')
        else
            spoon.CodeSnippets.snippet('function-' .. item.method)
        end

        BracketMatching.start()
    end,
})
