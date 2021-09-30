local CodeSnippets = {}
CodeSnippets.__index = CodeSnippets

dofile(hs.configdir .. '/Spoons/Modes/CodeSnippets.spoon/method-modal.lua')
dofile(hs.configdir .. '/Spoons/Modes/CodeSnippets.spoon/function-modal.lua')
dofile(hs.configdir .. '/Spoons/Modes/CodeSnippets.spoon/call-function-modal.lua')
dofile(hs.configdir .. '/Spoons/Modes/CodeSnippets.spoon/extra-snippets-modal.lua')
dofile(hs.configdir .. '/Spoons/Modes/CodeSnippets.spoon/general-snippets-modal.lua')

CodeSnippets.lookup = {
    e = 'snippet-elseif',
    t = 'this',
    d = 'dd',

    y = nil,
    u = 'extraSnippetsModal',
    i = 'snippet-if',
    o = nil,
    p = 'snippet-property',
    open_bracket = 'echo',
    close_bracket = nil,
    h = nil,
    j = 'generalSnippetsModal',
    k = nil,
    l = 'snippet-log',
    semicolon = 'insertColon',
    quote = 'insertQuotes',
    return_or_enter = nil,
    n = 'functionSnippet',
    m = 'method',
    comma = 'insertComma',
    period = 'callFunction',
    slash = 'insertQuestion',
    right_shift = nil,
    spacebar = nil,
}

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
                spoon.CaseDialog.handle('k')
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
        Modal.enter('CodeSnippets:callFunction')
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

function CodeSnippets.generalSnippetsModal()
    Modal.enter('CodeSnippets:generalSnippets')
end

function CodeSnippets.extraSnippetsModal()
    Modal.enter('CodeSnippets:extraSnippets')
end

function CodeSnippets.callFunction()
    Modal.enter('CodeSnippets:callFunction')
end

function CodeSnippets.handleCallFunction(item)
    if item.extra ~= 'start' then
        Modal.exit()
    end

    if item.method == 'static' then
        insertText('::')
        Modal.enter('CodeSnippets:callFunction')

        return
    end

    if item.extra then
        return CodeSnippets.printFunction(item)
    end

    CodeSnippets.printFunction(item)
    -- CodeSnippets.printFunction(item, getSelectedText())
end

function CodeSnippets.printFunction(item, text)
    if text and inCodeEditor() then
        fastKeyStroke({'shift'}, 'delete')
        fastKeyStroke({'shift', 'cmd'}, 'i')
    end

    insertText(item.method);

    if item.extra ~= 'start' then
        insertText('(')
    end

    if item.extra == 'query' then
        insertText('function ($query) { $query-> }')
        insertText(')')
        fastKeyStroke('left')
        fastKeyStroke('left')
        fastKeyStroke('left')
        Modal.enter('CodeSnippets:callFunction.laravelWhere')

        return
    elseif text then
        insertText(text)
    end

    if item.extra == 'start' then
        return
    end

    insertText(')')
    fastKeyStroke('left')

    if item.extra ~= 'simple' then
        BracketMatching.start()
    end
end

return CodeSnippets
