local CodeMode = {}
CodeMode.__index = CodeMode

function CodeMode.y()
    insertText(' && ')
end

function CodeMode.u()
    if appIs(iterm) then
        -- Git: Discard changes
        typeAndEnter('nah')
    else
        -- Atom: Add use statement
        fastKeyStroke({'ctrl', 'alt'}, 'u')
    end
end

function CodeMode.i()
    -- Multiple cursors up
    if appIs(atom) then
        fastKeyStroke({'shift', 'ctrl'}, 'up')
    elseif appIs(sublime) then
        fastKeyStroke({'shift', 'ctrl', 'alt'}, 'up')
    end
end

function CodeMode.o()
    if appIs(iterm) then
        typeAndEnter('git:checkout')
    end
end

function CodeMode.p()
    if appIs(iterm) then
        typeAndEnter('git push')
    else
        insertText(' || ')
    end
end

function CodeMode.open_bracket()
    -- Fold
    fastKeyStroke({'alt', 'cmd'}, '[')
end

function CodeMode.close_bracket()
    -- Unfold
    fastKeyStroke({'alt', 'cmd'}, ']')
end

function CodeMode.h()
    if appIs(iterm) then
        typeAndEnter('git:status')
    end
end

function CodeMode.j()
    if appIs(iterm) then
        -- iTerm: Autocomplete next word
        fastKeyStroke({'shift', 'alt', 'cmd'}, 'j')
    elseif appIs(notion) then
        fastKeyStroke({'shift', 'cmd'}, 'down')
    elseif appIs(atom) or appIs(sublime) then
        -- Atom, Sublime: Move line down
        fastKeyStroke({'ctrl', 'cmd'}, 'down')
    end
end

function CodeMode.k()
    if appIs(notion) then
        fastKeyStroke({'shift', 'cmd'}, 'up')
        fastKeyStroke({'shift', 'cmd'}, 'up')
    elseif appIs(atom) or appIs(sublime) then
        -- Atom, Sublime: Move line up
        fastKeyStroke({'ctrl', 'cmd'}, 'up')
    end
end

function CodeMode.l()
    if appIs(iterm) then
        typeAndEnter('git pull')
    else
        Pending.run({
            function()
                -- Go to definition
                fastKeyStroke({'alt', 'cmd'}, 'down')
            end,
            function()
                spoon.YankMode.word()
                goToFileInAtom(hs.pasteboard.getContents())
            end,
        })
    end
end

function CodeMode.semicolon()
    -- Atom: Toggle semicolon at end of line
    fastKeyStroke({'alt'}, ';')
end

function CodeMode.quote()
    Pending.run({
        function()
            insertText(' = ')
        end,
        function()
            insertText(' == ')
        end,
        function()
            if titleContains('.lua') then
                insertText(' ~= ')
            else
                insertText(' != ')
            end
        end,
    })
end

function CodeMode.return_or_enter()
    if appIs(iterm) then
        ProjectManager.serveCurrent()
    else
        insertText('return')
    end
end

function CodeMode.b()
    if appIs(sublime) then
        fastKeyStroke({'alt', 'cmd'}, 'x')
    elseif appIs(atom) then
        -- Toggle Boolean
        fastKeyStroke('-')
    end
end

function CodeMode.n()
    -- Select next word
    fastKeyStroke({'cmd'}, 'd')
end

function CodeMode.m()
    if appIs(iterm) then
        typeAndEnter('git:merge')
    else
        -- Multiple cursors down
        fastKeyStroke({'shift', 'ctrl', 'alt'}, 'down')
    end
end

function CodeMode.comma()
    -- Atom: Toggle comma at end of line
    fastKeyStroke({'alt'}, ',')
end

function CodeMode.period()
    insertText(' => ')
end

function CodeMode.slash()
    -- Atom: Go to matching bracket
    fastKeyStroke({'ctrl'}, 'm')
end

function CodeMode.spacebar()
    -- Comment
    fastKeyStroke({'cmd'}, '/')
end

return CodeMode
