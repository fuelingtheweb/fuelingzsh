local mdl = {}
mdl.__index = mdl

Modal.add({
    key = 'CodeSnippets:method',
    title = 'Snippet: Method',
    items = {
        m = {name = 'primary', method = 'primary'},
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
        Modal.exit()

        if item.method == 'primary' then
            if appIs(atom) and titleContains('Test.php') then
                spoon.CodeSnippets.snippet('method-test')
                spoon.CaseDialog.handle('k')
            elseif appIncludes({atom, sublime}) then
                spoon.CodeSnippets.snippet('method')
                spoon.CaseDialog.handle('m')
            end

            return
        end

        spoon.CodeSnippets.snippet('method-' .. item.method)
    end,
})

return mdl
