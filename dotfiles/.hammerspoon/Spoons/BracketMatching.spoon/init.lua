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
    tag = {'<', '>'}
}

Modal.add({
    key = 'BracketMatching',
    title = 'Bracket Matching',
    items = {
        -- numbers
        -- tab, qwer
        t = {action = 'thisSnippet'},
        -- yu
        i = {action = 'onlyOpening'},
        o = {action = 'onlyClosing'},
        p = {action = 'paste'},
        -- ['['] = {action = 'cancel'},
        -- ]\
        -- caps, a
        s = {bracket = 'singleQuote'},
        d = {bracket = 'doubleQuote'},
        f = {bracket = 'parenthesis'},
        -- g
        h = {action = 'left'},
        k = {action = 'insertVariable'},
        l = {action = 'right'},
        [';'] = {action = 'insertSemicolon'},
        -- ["'"],
        ['return'] = {action = 'newLine'},
        -- left shift
        z = {bracket = 'backTick'},
        -- x
        c = {bracket = 'braces'},
        -- v
        b = {bracket = 'brackets'},
        n = {action = 'functionSnippet'},
        m = {action = 'cancel'},
        [','] = {action = 'insertComma'},
        ['.'] = {action = 'continueChain'},
        -- /, right shift
        space = {bracket = 'space'}
    },
    callback = function(item)
        BracketMatching.start()

        if item.action then return BracketMatching[item.action]() end

        BracketMatching.print(item.bracket)
    end,
    beforeExit = function()
        BracketMatching.commitOrDismiss()

        return true
    end,
    exited = function()
        BracketMatching.multi = false
        BracketMatching.brackets = {}
    end
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
    -- local text = getSelectedText()
    local text = nil

    BracketMatching.start()

    if hasValue({'singleQuote', 'doubleQuote', 'tag'}, bracket) then
        Modal.exit()
    end

    if text then
        if appIs(vscode) then
            ks.shiftAltCmd('delete')
        elseif inCodeEditor() then
            ks.shift('delete')
            ks.shiftCmd('i')
        end
    end

    if text then BracketMatching.dismiss() end

    ks.type(brackets[1] .. (text or '') .. brackets[2])

    ks.key('left')
end

function BracketMatching.start() Modal.enter('BracketMatching') end

function BracketMatching.commitOrDismiss()
    if not BracketMatching.multi then return BracketMatching.dismiss() end

    local text = getSelectedText()
    local brackets = hs.fnutils.copy(BracketMatching.brackets)

    BracketMatching.dismiss()

    if text then
        if appIs(vscode) then
            ks.slow().key('c')
            ks.undo()
            ks.shiftAltCmd('delete')
        elseif inCodeEditor() then
            ks.shift('delete')
            ks.shiftCmd('i')
        end
    end

    local result = ''

    each(brackets, function(bracket)
        result = result .. BracketMatching.lookup[bracket][1]
    end)

    if text then result = result .. text end

    for i = #brackets, 1, -1 do
        result = result .. BracketMatching.lookup[brackets[i]][2]
    end

    ks.type(result)
end

function BracketMatching.dismiss() Modal.exit() end

function BracketMatching.newLine()
    Modal.exit()
    ks.enter()
end

function BracketMatching.cancel()
    ks.key('right')
    ks.key('delete')
    ks.key('delete')
end

function BracketMatching.left()
    Modal.exit()
    ks.key('left')
end

function BracketMatching.right()
    Modal.exit()
    ks.key('right')
end

function BracketMatching.paste()
    Modal.exit()
    ks.paste()
end

function BracketMatching.insertComma()
    Modal.exit()
    ks.key('right')
    ks.type(',')
end

function BracketMatching.insertSemicolon()
    Modal.exit()
    ks.key('right')
    ks.type(';')
end

function BracketMatching.continueChain()
    Modal.exit()
    ks.key('right')
    if isLua() then
        ks.type('.')
    else
        ks.type('->')
    end
    -- Modal.enter('CodeSnippets:callFunction')
end

function BracketMatching.insertVariable()
    Modal.exit()
    ks.type('$')
end

function BracketMatching.onlyOpening()
    ks.key('right')
    ks.key('delete')
end

function BracketMatching.onlyClosing()
    ks.key('delete')
    ks.key('right')
end

function BracketMatching.functionSnippet()
    Modal.exit()
    md.CodeSnippets.snippet('function')
    BracketMatching.start()
end

function BracketMatching.thisSnippet()
    Modal.exit()
    md.CodeSnippets.snippet('this')
end

return BracketMatching
