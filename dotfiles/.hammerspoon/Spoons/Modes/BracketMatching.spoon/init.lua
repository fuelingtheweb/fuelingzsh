local BracketMatching = {}
BracketMatching.__index = BracketMatching

BracketMatching.multi = false
BracketMatching.brackets = {}

BracketMatching.lookup = {
    singleQuote = {"'", "'"},
    doubleQuote = {'"', '"'},
    backTick = {'`', '`'},
    parenthesis = {'(', ')'},
    braces = {'{', '}'},
    brackets = {'[', ']'},
    space = {' ', ' '},
    tag = {'<', '>'},
}

Modal.addWithMenubar({
    key = 'BracketMatching',
    title = 'Bracket Matching',
    shortcuts = {
        items = {
            -- numbers
            -- tab, qwer
            {key = 't', action = 'thisSnippet'},
            -- yu
            {key = 'i', action = 'onlyOpening'},
            {key = 'o', action = 'onlyClosing'},
            {key = 'p', action = 'paste'},
            {key = '[', action = 'cancel'},
            -- ]\
            -- caps, a
            {key = 's', bracket = 'singleQuote'},
            {key = 'd', bracket = 'doubleQuote'},
            {key = 'f', bracket = 'parenthesis'},
            -- g
            {key = 'h', action = 'left'},
            -- j
            {key = 'k', action = 'insertVariable'},
            {key = 'l', action = 'right'},
            {key = ';', action = 'insertSemicolon'},
            {key = "'", action = 'insertNull'},
            {key = 'return', action = 'newLine'},
            -- left shift
            {key = 'z', bracket = 'backTick'},
            -- x
            {key = 'c', bracket = 'braces'},
            -- v
            {key = 'b', bracket = 'brackets'},
            {key = 'n', action = 'functionSnippet'},
            {key = 'm', action = 'commitOrDismiss'},
            {key = ',', action = 'insertComma'},
            {key = '.', action = 'continueChain'},
            -- /, right shift
            {key = 'space', bracket = 'space'},
        },
        callback = function(item)
            BracketMatching.start()

            if item.action then
                return BracketMatching[item.action]()
            end

            BracketMatching.print(item.bracket)
        end,
    },
    exited = function()
        BracketMatching.multi = false
        BracketMatching.brackets = {}
    end,
})

function BracketMatching.startMulti()
    BracketMatching.multi = true
    BracketMatching.start()
end

function BracketMatching.print(bracket)
    if BracketMatching.multi then
        table.insert(BracketMatching.brackets, bracket)
        return
    end

    local brackets = BracketMatching.lookup[bracket]
    local text = getSelectedText()

    BracketMatching.start()

    if hasValue({'singleQuote', 'doubleQuote', 'tag'}, bracket) then
        Modal.exit()
    end

    if text and inCodeEditor() then
        fastKeyStroke({'shift'}, 'delete')
        fastKeyStroke({'shift', 'cmd'}, 'i')
    end

    insertText(brackets[1])

    if text then
        BracketMatching.dismiss()
        insertText(text)
    end

    insertText(brackets[2])
    fastKeyStroke('left')
end

function BracketMatching.start()
    Modal.enter('BracketMatching')
end

function BracketMatching.commitOrDismiss()
    if not BracketMatching.multi then
        return BracketMatching.dismiss()
    end

    local text = getSelectedText()

    if text and inCodeEditor() then
        fastKeyStroke({'shift'}, 'delete')
        fastKeyStroke({'shift', 'cmd'}, 'i')
    end

    each(BracketMatching.brackets, function(bracket)
        local brackets = BracketMatching.lookup[bracket]
        insertText(brackets[1])
    end)

    if text then
        insertText(text)
    end

    for i = #BracketMatching.brackets, 1, -1 do
        local brackets = BracketMatching.lookup[BracketMatching.brackets[i]]
        insertText(brackets[2])
    end

    BracketMatching.dismiss()
end

function BracketMatching.dismiss()
    Modal.exit()
end

function BracketMatching.newLine()
    Modal.exit()
    fastKeyStroke('return');
end

function BracketMatching.cancel()
    fastKeyStroke('right');
    fastKeyStroke('delete');
    fastKeyStroke('delete');
end

function BracketMatching.left()
    Modal.exit()
    fastKeyStroke('left');
end

function BracketMatching.right()
    Modal.exit()
    fastKeyStroke('right');
end

function BracketMatching.paste()
    Modal.exit()
    fastKeyStroke({'cmd'}, 'v');
end

function BracketMatching.insertComma()
    Modal.exit()
    fastKeyStroke('right');
    insertText(',')
end

function BracketMatching.insertSemicolon()
    Modal.exit()
    fastKeyStroke('right');
    insertText(';')
end

function BracketMatching.continueChain()
    Modal.exit()
    fastKeyStroke('right');
    insertText('->')
end

function BracketMatching.insertVariable()
    Modal.exit()
    insertText('$')
end

function BracketMatching.insertNull()
    Modal.exit()
    insertText('null')
end

function BracketMatching.onlyOpening()
    fastKeyStroke('right');
    fastKeyStroke('delete');
end

function BracketMatching.onlyClosing()
    fastKeyStroke('delete');
    fastKeyStroke('right');
end

function BracketMatching.functionSnippet()
    Modal.exit()
    spoon.CodeSnippets.snippet('function')
end

function BracketMatching.thisSnippet()
    Modal.exit()
    spoon.CodeSnippets.snippet('this')
end

return BracketMatching
