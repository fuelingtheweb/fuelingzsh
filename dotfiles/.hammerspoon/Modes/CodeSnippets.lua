local CodeSnippets = {}
CodeSnippets.__index = CodeSnippets

loadModal('CodeSnippets.Method')
loadModal('CodeSnippets.Function')
loadModal('CodeSnippets.CallFunction')
loadModal('CodeSnippets.Extra')
loadModal('CodeSnippets.General')
loadModal('CodeSnippets.Equals')

CodeSnippets.lookup = {
    e = 'snippet-elseif',
    t = 'this',
    d = 'dd',

    y = 'conditionalAnd',
    u = 'extraSnippetsModal',
    i = 'snippet-if',
    o = 'concatenate',
    p = 'conditionalOr',
    -- p = 'snippet-property',
    open_bracket = 'echo',
    close_bracket = nil,
    h = nil,
    j = 'generalSnippetsModal',
    k = nil,
    l = 'snippet-log',
    semicolon = 'insertColon',
    quote = 'equals',
    return_or_enter = 'typeReturn',
    n = 'functionSnippet',
    m = 'method',
    comma = 'insertComma',
    period = 'callFunction',
    slash = 'insertQuestion',
    right_shift = nil,
    spacebar = nil
}

function CodeSnippets.handle(key)
    if appIs(sublime) and titleContains('EOD.md') and key == 'semicolon' then
        fastKeyStroke('o')
        keyStroke('return')
        insertText(';dte')
        hs.timer.doAfter(0.2, function()
            keyStroke('return')
            insertText('- ')
            fastKeyStroke('escape')
            md.Command.save()
        end)

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
    local original = hs.pasteboard.getContents()
    hs.pasteboard.setContents('snippet-' .. name)

    if appIs(vscode) then
        fastKeyStroke({'ctrl', 'cmd'}, 's')
        fastKeyStroke({'cmd'}, 'v')
        keyStroke('return')

        if hasValue({'if'}, name) then BracketMatching.start() end
    elseif appIs(sublime) then
        typeAndTab('snippet-' .. name)
    else
        typeAndEnter('snippet-' .. name)
    end

    hs.timer.doAfter(1, function() hs.pasteboard.setContents(original) end)
end

function CodeSnippets.method() Modal.enter('CodeSnippets:method') end

function CodeSnippets.functionSnippet() Modal.enter('CodeSnippets:function') end

function CodeSnippets.this()
    if appIncludes({atom, vscode}) then
        keyStroke({'shift', 'ctrl'}, 'c')

        if stringContains('migrations', hs.pasteboard.getContents()) then
            return insertText('$table->')
        end
    end

    if appIncludes({atom, sublime, vscode}) then CodeSnippets.snippet('this') end
end

function CodeSnippets.dd()
    CodeSnippets.snippet('dd')
    BracketMatching.start()
end

function CodeSnippets.echo()
    CodeSnippets.snippet('echo')
    BracketMatching.start()
end

function CodeSnippets.equals() Modal.enter('CodeSnippets:equals') end

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

function CodeSnippets.callFunction() Modal.enter('CodeSnippets:callFunction') end

function CodeSnippets.handleCallFunction(item)
    if item.extra ~= 'start' then Modal.exit() end

    if item.method == 'static' then
        insertText('::')
        Modal.enter('CodeSnippets:callFunction')

        return
    end

    if item.extra then return CodeSnippets.printFunction(item) end

    CodeSnippets.printFunction(item)
    -- CodeSnippets.printFunction(item, getSelectedText())
end

function CodeSnippets.printFunction(item, text)
    if text and inCodeEditor() then
        fastKeyStroke({'shift'}, 'delete')
        fastKeyStroke({'shift', 'cmd'}, 'i')
    end

    insertText(item.method);

    if item.extra ~= 'start' then insertText('(') end

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

    if item.extra == 'start' then return end

    insertText(')')
    fastKeyStroke('left')

    if item.extra ~= 'simple' then BracketMatching.start() end
end

function CodeSnippets.conditionalAnd()
    if isLua() then
        insertText(' and ')
    else
        insertText(' && ')
    end
end

function CodeSnippets.conditionalOr()
    handleConditional(titleContains, insertText, {
        {condition = '.lua', value = ' or '},
        {condition = 'fallback', value = ' || '} -- ['.lua'] = ' or ',
        -- ['fallback'] = ' || ',
    })
    -- if isLua() then
    --     insertText(' or ')
    -- else
    --     insertText(' || ')
    -- end
end

function CodeSnippets.concatenate()
    if titleContains('.php') then
        insertText(' . ')
    elseif isLua() then
        insertText(' .. ')
    elseif titleContains('.js') then
        insertText(' + ')
    end

    BracketMatching.start()
end

function CodeSnippets.typeReturn() insertText('return') end

return CodeSnippets
