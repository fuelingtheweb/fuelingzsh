Modal.add({
    key = 'CodeSnippets:method',
    title = 'Snippet: Method',
    items = {
        n = {name = '__construct', method = 'construct'},
        i = {name = 'index', method = 'index'},
        c = {name = 'create', method = 'create'},
        s = {name = 'store', method = 'store'},
        h = {name = 'show', method = 'show'},
        e = {name = 'edit', method = 'edit'},
        u = {name = 'update', method = 'update'},
        d = {name = 'destroy', method = 'destroy'},
        g = {name = 'Model getter', method = 'getter'},
        q = {name = 'Model scope', method = 'scope'},
        r = {name = 'Model relationship', method = 'relationship'},
        t = {name = 'Test setup', method = 'test-setup'},
        o = {name = 'protected', method = 'protected'},
        v = {name = 'private', method = 'private'},
        [';'] = {name = 'static', method = 'static'},
    },
    callback = function(item)
        spoon.CodeSnippets.snippet('method-' .. item.method)
        Modal.exit()
    end,
})
