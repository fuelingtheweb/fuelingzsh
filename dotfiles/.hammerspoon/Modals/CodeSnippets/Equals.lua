local mdl = {}
mdl.__index = mdl

Modal.add({
    key = 'CodeSnippets:equals',
    title = 'Equals',
    items = {
        -- numbers
        -- tab, qwer
        t = {name = ' = $this->', method = 'thisSnippet'},
        -- yu
        i = {name = "=''", method = 'simpleSingleQuote'},
        o = {name = '=""', method = 'simpleDoubleQuote'},
        p = {name = ' = :clipboard', method = 'paste'},
        -- []\
        -- caps, a
        s = {name = " = ''", bracket = 'singleQuote'},
        d = {name = ' = ""', bracket = 'doubleQuote'},
        f = {name = ' = ()', bracket = 'parenthesis'},
        -- gh
        k = {name = ' = $', text = ' = $'},
        l = {name = ' === ', text = ' === '},
        [';'] = {name = ' == ', text = ' == '},
        ["'"] = {name = ' = ', method = 'equals'},
        -- return, left shift
        z = {name = ' = ``', bracket = 'backTick'},
        -- x
        c = {name = ' = {}', bracket = 'braces'},
        -- v
        b = {name = ' = []', bracket = 'brackets'},
        n = {name = ' ~== ', method = 'strictNotEquals'},
        m = {name = ' ~= ', method = 'simpleNotEquals'},
        -- ,
        ['.'] = {name = ' = :function', method = 'callFunction'}
        -- /, right shift, space
    },
    callback = function(item)
        Modal.exit()

        if item.method then
            mdl[item.method]()
        elseif item.bracket then
            mdl.equals()
            Brackets.print(item.bracket)
        elseif item.text then
            ks.type(item.text)

            if fn.table.has({' === ', ' == '}, item.text) then
                -- Brackets.startIfPhp()
            end
        end
    end
})

function mdl.equals()
    ks.type(' = ')
    -- Brackets.startIfPhp()
end

function mdl.thisSnippet()
    mdl.equals()
    md.CodeSnippets.snippet('this')
end

function mdl.simpleSingleQuote()
    ks.type("=''").left()
end

function mdl.simpleDoubleQuote()
    ks.type('=""').left()
    -- Brackets.startIfPhp()
end

function mdl.paste()
    mdl.equals()
    hs.timer.doAfter(0.1, ks.paste)
end

function mdl.simpleNotEquals()
    if is.lua() then
        ks.type(' ~= ')
    else
        ks.type(' != ')
        -- Brackets.startIfPhp()
    end
end

function mdl.strictNotEquals()
    if is.lua() then
        ks.type(' ~== ')
    else
        ks.type(' !== ')
        -- Brackets.startIfPhp()
    end
end

function mdl.callFunction()
    mdl.equals()
    Modal.enter('CodeSnippets:callFunction')
end

return mdl
