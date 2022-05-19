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
    i = 'snippetIf',
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
    if fn.window.titleContains('EOD.md') and key == 'semicolon' then
        ks.escape().shift('o').slow().enter().slow().up()
        ks.type('## ' .. os.date('%A, %b') .. ' ' .. os.date('%d'):gsub('^0', ''))

        hs.timer.doAfter(0.4, function()
            ks.slow().enter().type('- ')

            hs.timer.doAfter(0.2, function()
                md.Command.save()
            end)
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
    fn.clipboard.preserve(function()
        fn.clipboard.set('snippet-' .. name)

        ks.ctrlCmd('s').paste().slow().enter()

        if fn.table.has({'if'}, name) then
            Brackets.startIfPhp()
        end
    end)
end

function CodeSnippets.method()
    Modal.enter('CodeSnippets:method')
end

function CodeSnippets.functionSnippet()
    Modal.enter('CodeSnippets:function')
end

function CodeSnippets.this()
    ks.slow().shiftCtrl('c')

    if fn.clipboard.contains('migrations') then
        return ks.type('$table->')
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
    if is.todo() then
        ks.type('@today')
    else
        ks.type(' : ')
        Brackets.startIfPhp()
    end
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
    if is.todo() then
        ks.type('@high')
    else
        Modal.enter('CodeSnippets:extraSnippets')
    end
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
    if is.todo() then
        ks.type('@critical')
    elseif is.lua() then
        ks.type(' and ')
    else
        ks.type(' && ')
    end
end

function CodeSnippets.conditionalOr()
    if is.todo() then
        ks.type('@pr()').left()
    elseif is.lua() then
        ks.type(' or ')
    else
        ks.type(' || ')
    end
end

function CodeSnippets.concatenate()
    if is.todo() then
        return ks.type('@trello()').left()
    elseif is.php() then
        ks.type(' . ')
    elseif is.lua() then
        ks.type(' .. ')
    elseif is.js() then
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

function CodeSnippets.snippetIf()
    if is.todo() then
        ks.type('@low')
    else
        CodeSnippets.snippet('if')
    end
end

return CodeSnippets
