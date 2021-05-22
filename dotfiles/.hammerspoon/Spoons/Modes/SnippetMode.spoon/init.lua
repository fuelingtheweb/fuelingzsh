local SnippetMode = {}
SnippetMode.__index = SnippetMode

SnippetMode.lookup = {
    e = 'snippet-elseif',
    t = 'this',
    d = 'snippet-dd',

    y = nil,
    u = nil,
    i = 'snippet-if',
    o = nil,
    p = 'snippet-property',
    open_bracket = 'snippet-echo',
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
    comma = nil,
    period = nil,
    slash = 'insertQuestion',
    right_shift = nil,
    spacebar = nil,
}

SnippetMode.slack = {
    i = 'in',
    o = 'out',
    l = 'lunch',
    semicolon = 'break',
    return_or_enter = 'back',
    n = 'ofn',
}

Modal.addWithMenubar({
    key = 'SnippetMode:method',
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

            SnippetMode.snippet('method-' .. item.method)
            Modal.exit()
        end,
    },
})

Modal.addWithMenubar({
    key = 'SnippetMode:function',
    title = 'Snippet: Function',
    shortcuts = {
        items = {
            {key = 'v', name = 'validation', method = 'validation'},
            {key = 's', name = 'short', method = 'short'},
        },
        callback = function(item)
            SnippetMode.snippet('function-' .. item.method)
            Modal.exit()
        end,
    },
})

function SnippetMode.guard()
    return appIncludes({atom, sublime, slack})
end

function SnippetMode.handle(key)
    if appIs(slack) then
        lookup = SnippetMode.slack

        if lookup and lookup[key] then
            insertText('@' .. lookup[key])
            hs.timer.doAfter(.2, function()
                keyStroke('escape')
            end)
        end

        return
    end

    lookup = SnippetMode.lookup

    if lookup and lookup[key] then
        local callable = lookup[key]

        if callable then
            if SnippetMode[callable] then
                SnippetMode[callable](key)
            elseif SnippetMode.fallback then
                SnippetMode.fallback(callable, key)
            end
        end
    end
end

function SnippetMode.fallback(value)
    SnippetMode.snippet(value:gsub('snippet%-', ''))
end

function SnippetMode.snippet(name)
    if appIs(sublime) then
        typeAndTab('snippet-' .. name)
    else
        typeAndEnter('snippet-' .. name)
    end
end

function SnippetMode.method()
    Pending.run({
        function()
            if appIs(atom) and titleContains('Test.php') then
                SnippetMode.snippet('method-test')
            elseif appIncludes({atom, sublime}) then
                SnippetMode.snippet('method')
            end
        end,
        function()
            Modal.enter('SnippetMode:method')
        end,
    })
end

function SnippetMode.functionSnippet()
    Pending.run({
        function()
            SnippetMode.snippet('function')
        end,
        function()
            Modal.enter('SnippetMode:function')
        end,
    })
end

function SnippetMode.this()
    if appIs(atom) then
        keyStroke({'shift', 'ctrl'}, 'c')

        if stringContains('migrations', hs.pasteboard.getContents()) then
            return insertText('$table->')
        end
    end

    if appIncludes({atom, sublime}) then
        SnippetMode.snippet('this')
    end
end

function SnippetMode.insertQuotes()
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

function SnippetMode.insertColon()
    insertText(' : ')
end

function SnippetMode.insertQuestion()
    insertText(' ? ')
end

return SnippetMode
