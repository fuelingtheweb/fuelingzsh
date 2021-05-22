local BracketMatching = {}
BracketMatching.__index = BracketMatching

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
            {key = 's', bracket = 'singleQuote'},
            {key = 'd', bracket = 'doubleQuote'},
            {key = 'z', bracket = 'backTick'},
            {key = 'f', bracket = 'parenthesis'},
            {key = 'c', bracket = 'braces'},
            {key = 'b', bracket = 'brackets'},
            {key = 'space', bracket = 'space'},
            {key = 't', bracket = 'tag'},
            {key = 'i', action = 'insertVariable'},
            {key = 'm', action = 'dismiss'},
            {key = 'return', action = 'newLine'},
            {key = '[', action = 'cancel'},
            {key = 'l', action = 'right'},
            {key = 'h', action = 'left'},
            {key = 'p', action = 'paste'},
            {key = ',', action = 'insertComma'},
            {key = ';', action = 'insertSemicolon'},
            {key = '.', action = 'continueChain'},
        },
        callback = function(item)
            BracketMatching.start()

            if item.action then
                return BracketMatching[item.action]()
            end

            BracketMatching.print(item.bracket)
        end,
    },
})

function BracketMatching.print(bracket)
    local brackets = BracketMatching.lookup[bracket]
    local text = getSelectedText()

    BracketMatching.start()

    if has_value({'singleQuote', 'doubleQuote', 'tag'}, bracket) then
        Modal.exit()
    end

    if text and inCodeEditor() then
        fastKeyStroke('c')

        fastKeyStroke({'shift'}, 'left')
        local character = getSelectedText()

        if getSelectedText() == 'c' then
            fastKeyStroke('delete')
        else
            fastKeyStroke('right')
        end
    end

    insertText(brackets[1])

    if text then
        insertText(text)
    end

    insertText(brackets[2])
    fastKeyStroke('left')
    -- Pending.run({
    --     function()
    --         insertText(brackets[1])
    --         insertText(brackets[2])
    --         fastKeyStroke('left')
    --     end,
    --     function()
    --         insertText(brackets[1])
    --     end,
    --     function()
    --         insertText(brackets[2])
    --     end,
    -- })
end

function BracketMatching.start()
    Modal.enter('BracketMatching', 2)
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

return BracketMatching
