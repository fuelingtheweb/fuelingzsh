Modal.add({
    key = 'CodeSnippets:function',
    title = 'Snippet: Function',
    items = {
        v = {name = 'validation', method = 'validation'},
        s = {name = 'short', method = 'short'},
    },
    callback = function(item)
        spoon.CodeSnippets.snippet('function-' .. item.method)
        Modal.exit()
    end,
})
