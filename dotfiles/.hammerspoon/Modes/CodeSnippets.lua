local CodeSnippets = {}
CodeSnippets.__index = CodeSnippets

Modal.load('CodeSnippets.Method')
Modal.load('CodeSnippets.Function')
Modal.load('CodeSnippets.CallFunction')
Modal.load('CodeSnippets.Extra')
Modal.load('CodeSnippets.General')
Modal.load('CodeSnippets.Equals')

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
    l = 'log',
    semicolon = 'insertColon',
    quote = 'equals',
    return_or_enter = 'typeReturn',
    n = 'functionSnippet',
    m = 'method',
    comma = 'insertComma',
    period = 'callFunction',
    slash = 'insertQuestion',
    right_shift = nil,
    spacebar = nil,
}

function CodeSnippets.handle(key)
    if is.vscode() and titleContains('EOD.md') and key == 'semicolon' then
        ks.key('o').slow().enter().type(';dte')
        hs.timer.doAfter(0.2, function()
            ks.slow().enter().type('- ').escape()
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

    if is.vscode() then
        ks.ctrlCmd('s').paste().slow().enter()

        if hasValue({'if'}, name) then Brackets.startIfPhp() end
    else
        ks.type('snippet-' .. name).enter()
    end

    hs.timer.doAfter(1, function()
        hs.pasteboard.setContents(original)
    end)
end

function CodeSnippets.method()
    Modal.enter('CodeSnippets:method')
end

function CodeSnippets.functionSnippet()
    Modal.enter('CodeSnippets:function')
end

function CodeSnippets.this()
    if is.vscode() then
        ks.slow().shiftCtrl('c')

        if stringContains('migrations', hs.pasteboard.getContents()) then
            return ks.type('$table->')
        end
    end

    if is.codeEditor() then
        CodeSnippets.snippet('this')
    end
end

function CodeSnippets.dd()
    CodeSnippets.snippet('dd')
    Brackets.startIfPhp()
end

function CodeSnippets.echo()
    CodeSnippets.snippet('echo')
    Brackets.startIfPhp()
end

function CodeSnippets.equals()
    Modal.enter('CodeSnippets:equals')
end

function CodeSnippets.insertColon()
    ks.type(' : ')
    Brackets.startIfPhp()
end

function CodeSnippets.insertQuestion()
    ks.type(' ? ')
    Brackets.startIfPhp()
end

function CodeSnippets.insertComma()
    ks.type(', ')
    Brackets.startIfPhp()
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
        ks.type('::')
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
    if text and is.codeEditor() then
        ks.shift('delete').shiftCmd('i')
    end

    ks.type(item.method)

    if item.extra ~= 'start' then
        ks.type('(')
    end

    if item.extra == 'query' then
        ks.type('function ($query) { $query-> }')
        ks.type(')').left().left().left()
        Modal.enter('CodeSnippets:callFunction.laravelWhere')

        return
    elseif text then
        ks.type(text)
    end

    if item.extra == 'start' then
        return
    end

    ks.type(')').left()

    if item.extra ~= 'simple' then Brackets.startIfPhp() end
end

function CodeSnippets.conditionalAnd()
    if is.lua() then
        ks.type(' and ')
    else
        ks.type(' && ')
    end
end

function CodeSnippets.conditionalOr()
    -- handleConditional(titleContains, insertText, {
    --     {condition = '.lua', value = ' or '},
    --     {condition = 'fallback', value = ' || '}, -- ['.lua'] = ' or ',
    --     -- ['fallback'] = ' || ',
    -- })
    if is.lua() then
        ks.type(' or ')
    else
        ks.type(' || ')
    end
end

function CodeSnippets.concatenate()
    if titleContains('.php') then
        ks.type(' . ')
    elseif is.lua() then
        ks.type(' .. ')
    elseif titleContains('.js') then
        ks.type(' + ')
    end

    Brackets.startIfPhp()
end

function CodeSnippets.typeReturn()
    ks.type('return')
end

function CodeSnippets.log()
    if is.lua() then
        ks.type('log.d()').left()
    else
        ks.type('console.log()').left()
    end
end

return CodeSnippets
