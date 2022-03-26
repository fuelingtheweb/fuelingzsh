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
            BracketMatching.print(item.bracket)
        elseif item.text then
            insertText(item.text)

            if hasValue({' === ', ' == '}, item.text) then
                BracketMatching.start()
            end
        end
    end
})

function mdl.equals()
    insertText(' = ')
    BracketMatching.start()
end

function mdl.thisSnippet()
    mdl.equals()
    md.CodeSnippets.snippet('this')
end

function mdl.simpleSingleQuote()
    insertText("=''")
    ks.key('left');
end

function mdl.simpleDoubleQuote()
    insertText('=""')
    ks.slow().key('left');
    BracketMatching.start()
end

function mdl.paste()
    mdl.equals()
    hs.timer.doAfter(0.1, function() ks.cmd('v'); end)
end

function mdl.simpleNotEquals()
    if isLua() then
        insertText(' ~= ')
    else
        insertText(' != ')
        BracketMatching.start()
    end
end

function mdl.strictNotEquals()
    if isLua() then
        insertText(' ~== ')
    else
        insertText(' !== ')
        BracketMatching.start()
    end
end

function mdl.callFunction()
    mdl.equals()
    Modal.enter('CodeSnippets:callFunction')
end

return mdl

