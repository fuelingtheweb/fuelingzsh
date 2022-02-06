Shortcuts:add('W', {slack = function() slackReaction(':wave:') end}):add('R', {
    slack = function() slackReaction() end,
    atom = function()
        path = currentTitle():match('~%S+')

        if hs.fs.pathToAbsolute(path .. '/routes/web.php') then
            openInAtom(path .. '/routes/web.php')
        end
    end,
    sublime = function()
        root = currentTitle():match('%S+$')
        path = currentTitle():match('^~%S+' .. root)

        if hs.fs.pathToAbsolute(path .. '/routes/web.php') then
            openInSublime(path .. '/routes/web.php')
        end
    end
}):add('T', {notion = 'tasks'}):add('E', {
    atom = function()
        path = currentTitle():match('~%S+')

        if hs.fs.pathToAbsolute(path .. '/.env') then
            openInAtom(path .. '/.env')
        elseif hs.fs.pathToAbsolute(path .. '/wp-config.php') then
            openInAtom(path .. '/wp-config.php')
        end
    end,
    vscode = function()
        path = currentTitle():match('~%S+')

        if hs.fs.pathToAbsolute(path .. '/.env') then
            openInCode(path .. '/.env')
        elseif hs.fs.pathToAbsolute(path .. '/wp-config.php') then
            openInCode(path .. '/wp-config.php')
        end
    end,
    sublime = function()
        root = currentTitle():match('%S+$')
        path = currentTitle():match('^~%S+' .. root)

        if hs.fs.pathToAbsolute(path .. '/.env') then
            openInSublime(path .. '/.env')
        elseif hs.fs.pathToAbsolute(path .. '/wp-config.php') then
            openInSublime(path .. '/wp-config.php')
        end
    end
}):add('S', {
    atom = function()
        openInSublime('/Users/nathan/Development/Atom/fueling-snippets/snippets')
    end,
    sublime = 'BetterSnippetManager: Edit Snippets'
}):add('Z', {iterm = 'wd fz'}):add('B', {
    atom = 'Application: Open Your Keymap',
    sublime = 'Preferences: Key Bindings',
    vscode = 'Preferences: Open Keyboard Shortcuts'
}):add('D', {
    notion = function()
        fastKeyStroke({'alt', 'cmd'}, '2')
        fastKeyStroke({'shift'}, '2')
    end,
    iterm = 'wd d'
}):add('0', {
    notion = function()
        -- Notion: Create text
        fastKeyStroke({'alt', 'cmd'}, '0')
    end
}):add('1', {
    notion = function()
        -- Notion: Create H1 heading
        fastKeyStroke({'alt', 'cmd'}, '1')
    end,
    sublime = function()
        fastKeyStroke('escape')
        fastKeyStroke({'shift'}, 'i')
        insertText('# ')
    end,
    default = function()
        fastKeyStroke({'cmd'}, 'left')
        insertText('# ')
    end
}):add('2', {
    notion = function()
        -- Notion: Create H2 heading
        fastKeyStroke({'alt', 'cmd'}, '2')
    end,
    sublime = function()
        fastKeyStroke('escape')
        fastKeyStroke({'shift'}, 'i')
        insertText('## ')
    end,
    default = function()
        fastKeyStroke({'cmd'}, 'left')
        insertText('## ')
    end
}):add('3', {
    notion = function()
        -- Notion: Create H3 heading
        fastKeyStroke({'alt', 'cmd'}, '3')
    end,
    sublime = function()
        fastKeyStroke('escape')
        fastKeyStroke({'shift'}, 'i')
        insertText('### ')
    end,
    default = function()
        fastKeyStroke({'cmd'}, 'left')
        insertText('### ')
    end
}):add('4', {
    notion = function()
        -- Notion: Create to-do checkbox
        fastKeyStroke({'alt', 'cmd'}, '4')
    end,
    sublime = function()
        if titleContains('.todo') then
            -- Sublime: Create to-do checkbox
            fastKeyStroke({'cmd'}, 'i')
        else
            fastKeyStroke({}, 'escape')
            fastKeyStroke({'shift'}, 'i')
            insertText('- ')
        end
    end,
    default = function()
        fastKeyStroke({'cmd'}, 'left')
        insertText('- ')
    end
}):add('5', {
    notion = function()
        -- Notion: Create bulleted list
        fastKeyStroke({'alt', 'cmd'}, '5')
    end,
    sublime = function()
        fastKeyStroke('escape')
        fastKeyStroke({'shift'}, 'i')
        insertText('- ')
    end,
    default = function()
        fastKeyStroke({'cmd'}, 'left')
        insertText('- ')
    end
}):add('6', {
    notion = function()
        -- Notion: Create numbered list
        fastKeyStroke({'alt', 'cmd'}, '6')
    end,
    sublime = function()
        fastKeyStroke({}, 'escape')
        fastKeyStroke({'shift'}, 'i')
        insertText('1. ')
    end,
    default = function()
        fastKeyStroke({'cmd'}, 'left')
        insertText('1. ')
    end
}):add('7', {
    notion = function()
        -- Notion: Create toggle list
        fastKeyStroke({'alt', 'cmd'}, '7')
    end
}):add('8', {
    notion = function()
        -- Notion: Create code block
        fastKeyStroke({'alt', 'cmd'}, '8')
    end
})
