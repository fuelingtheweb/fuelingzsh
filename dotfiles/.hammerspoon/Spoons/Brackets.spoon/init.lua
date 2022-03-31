local Brackets = {}
Brackets.__index = Brackets

Brackets.multi = false
Brackets.brackets = {}

Brackets.lookup = {
    singleQuote = {"'", "'"},
    doubleQuote = {'"', '"'},
    backTick = {'`', '`'},
    parenthesis = {'(', ')'},
    braces = {'{', '}'},
    brackets = {'[', ']'},
    space = {' ', ' '},
    tag = {'<', '>'},
}

Brackets.actionInsideLookup = {
    t = {mods = {}, key = 't'}, -- t -> tag
    s = {mods = {}, key = "'"}, -- s -> single quotes
    d = {mods = {'shift'}, key = "'"}, -- d -> double quotes
    z = {mods = {}, key = 'z'}, -- z -> back ticks
    f = {mods = {'shift'}, key = '9'}, -- f -> parenthesis
    c = {mods = {'shift'}, key = '['}, -- c -> braces
    b = {mods = {}, key = '['}, -- b -> brackets
}

Modal.add({
    key = 'Brackets',
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
        space = {bracket = 'space'},
    },
    callback = function(item)
        Brackets.start()

        if item.action then
            return Brackets[item.action]()
        end

        Brackets.print(item.bracket)
    end,
    beforeExit = function()
        Brackets.commitOrDismiss()

        return true
    end,
    exited = function()
        Brackets.multi = false
        Brackets.brackets = {}
    end,
})

function Brackets.startMulti()
    Brackets.multi = true
    Brackets.start()
end

function Brackets.print(bracket)
    if Brackets.multi then
        table.insert(Brackets.brackets, bracket)
        return
    end

    local brackets = Brackets.lookup[bracket]
    -- local text = getSelectedText()
    local text = nil

    Brackets.start()

    if hasValue({'singleQuote', 'doubleQuote', 'tag'}, bracket) then
        Modal.exit()
    end

    if text then
        if is.vscode() then
            ks.shiftAltCmd('delete')
        elseif is.codeEditor() then
            ks.shift('delete').shiftCmd('i')
        end
    end

    if text then
        Brackets.dismiss()
    end

    ks.type(brackets[1] .. (text or '') .. brackets[2])

    ks.left()
end

function Brackets.start()
    Modal.enter('Brackets')
end

function Brackets.commitOrDismiss()
    if not Brackets.multi then
        return Brackets.dismiss()
    end

    local text = getSelectedText()
    local brackets = hs.fnutils.copy(Brackets.brackets)

    Brackets.dismiss()

    if text then
        if is.vscode() then
            ks.slow().key('c').undo().shiftAltCmd('delete')
        elseif is.codeEditor() then
            ks.shift('delete').shiftCmd('i')
        end
    end

    local result = ''

    each(brackets, function(bracket)
        result = result .. Brackets.lookup[bracket][1]
    end)

    if text then result = result .. text end

    for i = #brackets, 1, -1 do
        result = result .. Brackets.lookup[brackets[i]][2]
    end

    ks.type(result)
end

function Brackets.dismiss()
    Modal.exit()
end

function Brackets.newLine()
    Modal.exit()
    ks.enter()
end

function Brackets.cancel()
    ks.right().delete().delete()
end

function Brackets.left()
    Modal.exit()
    ks.left()
end

function Brackets.right()
    Modal.exit()
    ks.right()
end

function Brackets.paste()
    Modal.exit()
    ks.paste()
end

function Brackets.insertComma()
    Modal.exit()
    ks.right().type(',')
end

function Brackets.insertSemicolon()
    Modal.exit()
    ks.right().type(';')
end

function Brackets.continueChain()
    Modal.exit()
    ks.right()
    if is.lua() then
        ks.type('.')
    else
        ks.type('->')
    end
    -- Modal.enter('CodeSnippets:callFunction')
end

function Brackets.insertVariable()
    Modal.exit()
    ks.type('$')
end

function Brackets.onlyOpening()
    ks.right().delete()
end

function Brackets.onlyClosing()
    ks.delete().right()
end

function Brackets.functionSnippet()
    Modal.exit()
    md.CodeSnippets.snippet('function')
    Brackets.start()
end

function Brackets.thisSnippet()
    Modal.exit()
    md.CodeSnippets.snippet('this')
end

function Brackets.selectInside(key)
    Brackets.actionInside('v', key)
end

function Brackets.destroyInside(key)
    Brackets.actionInside('d', key)
end

function Brackets.yankInside(key)
    Brackets.actionInside('y', key)
end

function Brackets.pasteInside(key)
    Brackets.selectInside(key)
    md.Paste.primaryVim()
end

function Brackets.changeInside(key)
    Brackets.actionInside('c', key)

    if not hasValue({'s', 'd', 't'}, key) then
        Brackets.start()
    end
end

function Brackets.actionInside(action, key)
    if is.notVimMode() then
        return
    end

    keystroke = Brackets.actionInsideLookup[key]

    ks.escape().sequence({action, 'i'}).fire(keystroke.mods, keystroke.key)
end

return Brackets