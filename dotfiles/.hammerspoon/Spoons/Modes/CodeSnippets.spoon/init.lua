local CodeSnippets = {}
CodeSnippets.__index = CodeSnippets

CodeSnippets.lookup = {
    e = 'snippet-elseif',
    t = 'this',
    d = 'dd',

    y = nil,
    u = nil,
    i = 'snippet-if',
    o = nil,
    p = 'snippet-property',
    open_bracket = 'echo',
    close_bracket = nil,
    h = nil,
    j = nil,
    k = nil,
    l = 'snippet-log',
    semicolon = 'insertColon',
    quote = 'insertQuotes',
    return_or_enter = nil,
    n = 'functionSnippet',
    m = 'method',
    comma = 'insertComma',
    period = nil,
    slash = 'insertQuestion',
    right_shift = nil,
    spacebar = nil,
}

Modal.addWithMenubar({
    key = 'CodeSnippets:method',
    title = 'Snippet: Method',
    shortcuts = {
        items = {
            {key = 'n', name = '__construct', method = 'construct'},
            {key = 'i', name = 'index', method = 'index'},
            {key = 'c', name = 'create', method = 'create'},
            {key = 's', name = 'store', method = 'store'},
            {key = 'h', name = 'show', method = 'show'},
            {key = 'e', name = 'edit', method = 'edit'},
            {key = 'u', name = 'update', method = 'update'},
            {key = 'd', name = 'destroy', method = 'destroy'},
            {key = 'g', name = 'Model getter', method = 'getter'},
            {key = 'q', name = 'Model scope', method = 'scope'},
            {key = 'r', name = 'Model relationship', method = 'relationship'},
            {key = 't', name = 'Test setup', method = 'test-setup'},
            {key = 'o', name = 'protected', method = 'protected'},
            {key = 'v', name = 'private', method = 'private'},
            {key = ';', name = 'static', method = 'static'},
            {key = 'space', name = 'cheatsheet', method = 'cheatsheet'},
        },
        callback = function(item)
            if item.method == 'cheatsheet' then
                return spoon.ModalMgr:toggleCheatsheet()
            end

            CodeSnippets.snippet('method-' .. item.method)
            Modal.exit()
        end,
    },
})

Modal.addWithMenubar({
    key = 'CodeSnippets:function',
    title = 'Snippet: Function',
    shortcuts = {
        items = {
            {key = 'v', name = 'validation', method = 'validation'},
            {key = 's', name = 'short', method = 'short'},
        },
        callback = function(item)
            CodeSnippets.snippet('function-' .. item.method)
            Modal.exit()
        end,
    },
})

function CodeSnippets.handle(key)
    if appIs(sublime) and titleContains('EOD.md') and key == 'semicolon' then
        fastKeyStroke('o')
        fastKeyStroke('return')
        insertText(';dte')

        return
    end

    lookup = CodeSnippets.lookup

    if lookup and lookup[key] then
        local callable = lookup[key]

        if callable then
            if CodeSnippets[callable] then
                CodeSnippets[callable](key)
            elseif CodeSnippets.fallback then
                CodeSnippets.fallback(callable, key)
            end
        end
    end
end

function CodeSnippets.fallback(value)
    CodeSnippets.snippet(value:gsub('snippet%-', ''))
end

function CodeSnippets.snippet(name)
    if appIs(sublime) then
        typeAndTab('snippet-' .. name)
    else
        typeAndEnter('snippet-' .. name)
    end
end

function CodeSnippets.method()
    Pending.run({
        function()
            if appIs(atom) and titleContains('Test.php') then
                CodeSnippets.snippet('method-test')
            elseif appIncludes({atom, sublime}) then
                CodeSnippets.snippet('method')
            end
        end,
        function()
            Modal.enter('CodeSnippets:method')
        end,
    })
end

function CodeSnippets.functionSnippet()
    Pending.run({
        function()
            CodeSnippets.snippet('function')
            BracketMatching.start()
        end,
        function()
            Modal.enter('CodeSnippets:function')
        end,
    })
end

function CodeSnippets.this()
    if appIs(atom) then
        keyStroke({'shift', 'ctrl'}, 'c')

        if stringContains('migrations', hs.pasteboard.getContents()) then
            return insertText('$table->')
        end
    end

    if appIncludes({atom, sublime}) then
        CodeSnippets.snippet('this')
    end
end

function CodeSnippets.dd()
    CodeSnippets.snippet('dd')
    BracketMatching.start()
end

function CodeSnippets.echo()
    CodeSnippets.snippet('echo')
    BracketMatching.start()
end

function CodeSnippets.insertQuotes()
    Pending.run({
        function()
            insertText('=""')
            fastKeyStroke('left')
        end,
        function()
            insertText("=''")
            fastKeyStroke('left')
        end,
    })
end

function CodeSnippets.insertColon()
    insertText(' : ')
    BracketMatching.start();
end

function CodeSnippets.insertQuestion()
    insertText(' ? ')
    BracketMatching.start();
end

function CodeSnippets.insertComma()
    insertText(', ')
    BracketMatching.start();
end

return CodeSnippets
