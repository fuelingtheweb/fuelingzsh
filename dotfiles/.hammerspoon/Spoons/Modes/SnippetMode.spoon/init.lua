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
    semicolon = nil,
    quote = nil,
    return_or_enter = nil,
    n = 'snippet-af',
    m = 'method',
    comma = nil,
    period = nil,
    slash = nil,
    right_shift = nil,
    spacebar = nil,
}

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

function SnippetMode.guard()
    return appIncludes({atom, sublime})
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

return SnippetMode
