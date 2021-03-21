local BracketMatching = {}
BracketMatching.__index = BracketMatching

BracketMatching.lookup = {
    singleQuote = {"'", "'"},
    doubleQuote = {'"', '"'},
    backTick = {'`', '`'},
    parenthesis = {'(', ')'},
    braces = {'{', '}'},
    brackets = {'[', ']'},
}

Modal.addWithMenubar({
    key = 'BracketMatching',
    title = 'Bracket Matching',
    shortcuts = {
        items = {
            {key = 's', action = 'singleQuote'},
            {key = 'd', action = 'doubleQuote'},
            {key = 'z', action = 'backTick'},
            {key = 'f', action = 'parenthesis'},
            {key = 'c', action = 'braces'},
            {key = 'b', action = 'brackets'},
            {key = 'i', action = 'dismiss'},
            {key = 'return', action = 'dismiss'},
        },
        callback = function(item)
            if item.action == 'dismiss' then
                return Modal.exit()
            end

            local brackets = BracketMatching.lookup[item.action]

            Pending.run({
                function()
                    insertText(brackets[1])
                    insertText(brackets[2])
                    fastKeyStroke('left')
                end,
                function()
                    insertText(brackets[1])
                end,
                function()
                    insertText(brackets[2])
                end,
            })
        end,
    },
})

function BracketMatching.start()
    Modal.enter('BracketMatching')
end

return BracketMatching
