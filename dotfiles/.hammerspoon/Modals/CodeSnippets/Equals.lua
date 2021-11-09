local mdl = {}
mdl.__index = mdl

Modal.add({
    key = 'CodeSnippets:equals',
    title = 'Equals',
    items = {
        -- numbers
        -- tab, qwer
        t = {method = 'thisSnippet'},
        -- yu
        i = {method = 'simpleSingleQuote'},
        o = {method = 'simpleDoubleQuote'},
        p = {method = 'paste'},
        -- []\
        -- caps, a
        s = {bracket = 'singleQuote'},
        d = {bracket = 'doubleQuote'},
        f = {bracket = 'parenthesis'},
        -- gh
        k = {text = ' = $'},
        l = {text = ' === '},
        [';'] = {text = ' == '},
        ["'"] = {method = 'equals'},
        -- return, left shift
        z = {bracket = 'backTick'},
        -- x
        c = {bracket = 'braces'},
        -- v
        b = {bracket = 'brackets'},
        n = {method = 'strictNotEquals'},
        m = {method = 'simpleNotEquals'},
        -- ,
        ['.'] = {method = 'callFunction'},
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
        end
    end,
})

function mdl.equals()
    insertText(' = ')
end

function mdl.thisSnippet()
    mdl.equals()
    md.CodeSnippets.snippet('this')
end

function mdl.simpleSingleQuote()
    insertText("=''")
    fastKeyStroke('left');
end

function mdl.simpleDoubleQuote()
    insertText('=""')
    fastKeyStroke('left');
end

function mdl.paste()
    mdl.equals()
    fastKeyStroke({'cmd'}, 'v');
end

function mdl.simpleNotEquals()
    if titleContains('.lua') then
        insertText(' ~= ')
    else
        insertText(' != ')
    end
end

function mdl.strictNotEquals()
    if titleContains('.lua') then
        insertText(' ~== ')
    else
        insertText(' !== ')
    end
end

function mdl.callFunction()
    mdl.equals()
    Modal.enter('CodeSnippets:callFunction')
end

return mdl

