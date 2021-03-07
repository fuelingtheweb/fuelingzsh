local SnippetMode = {}
SnippetMode.__index = SnippetMode

Modal.addWithMenubar({
    key = 'SnippetMode:method',
    title = 'Snippet: Method',
    shortcuts = {
        items = {
            {key = 'n', method = 'construct'},
            {key = 'i', method = 'index'},
            {key = 'c', method = 'create'},
            {key = 's', method = 'store'},
            {key = 'h', method = 'show'},
            {key = 'e', method = 'edit'},
            {key = 'u', method = 'update'},
            {key = 'd', method = 'destroy'},
            {key = 'g', method = 'getter'},
            {key = 'q', method = 'scope'},
            {key = 't', method = 'test-setup'},
            {key = 'o', method = 'protected'},
            {key = 'v', method = 'private'},
            {key = ';', method = 'static'},
        },
        callback = function(item)
            SnippetMode.snippet('method-' .. item.method)
            Modal.exit()
        end,
    },
})

function SnippetMode.t()
    SnippetMode.this()
end

function SnippetMode.m()
    Pending.run({
        SnippetMode.method,
        function()
            Modal.enter('SnippetMode:method')
        end,
    })
end

SnippetMode.lookup = {
     e = 'elseif',
     d = 'dd',
     i = 'if',
     p = 'property',
     open_bracket = 'echo',
     l = 'log',
     n = 'af',
}

function SnippetMode.handle(key)
    if not appIncludes({atom, sublime}) then
        return
    end

    if SnippetMode[key] then
        SnippetMode[key]()
    elseif SnippetMode.lookup[key] then
        SnippetMode.snippet(SnippetMode.lookup[key])
    end
end

function SnippetMode.snippet(name)
    if appIs(sublime) then
        typeAndTab('snippet-' .. name)
    else
        typeAndEnter('snippet-' .. name)
    end
end

function SnippetMode.method()
    if appIs(atom) and titleContains('Test.php') then
        SnippetMode.snippet('method-test')
    elseif appIncludes({atom, sublime}) then
        SnippetMode.snippet('method')
    end
end

function SnippetMode.this()
    if appIs(atom) then
        fastKeyStroke({'shift', 'ctrl'}, 'c')

        if stringContains('migrations', hs.pasteboard.getContents()) then
            return insertText('$table->')
        end
    end

    if appIncludes({atom, sublime}) then
        SnippetMode.snippet('this')
    end
end

return SnippetMode
