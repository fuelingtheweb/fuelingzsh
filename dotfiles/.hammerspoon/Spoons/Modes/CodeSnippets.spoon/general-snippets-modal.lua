Modal.add({
    key = 'CodeSnippets:generalSnippets',
    title = 'General Snippets',
    items = {
        n = 'new ',
        m = function()
            Modal.exit()
            if titleContains('.lua') then
                insertText('nil')
            else
                insertText('null')
            end
        end,
        t = 'true',
        o = 'protected ',
        p = 'public ',
        f = 'false',
        v = 'private ',
    },
    callback = function(item)
        Modal.exit()
        insertText(item)
    end,
})
