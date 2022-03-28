Shortcuts
    :add('W', {slack = function()
        slackReaction(':wave:')
    end})
    :add('R', {
        slack = function()
            slackReaction()
        end,
        atom = function()
            path = currentTitle():match('~%S+')

            if hs.fs.pathToAbsolute(path .. '/routes/web.php') then
                openInAtom(path .. '/routes/web.php')
            end
        end,
        vscode = function()
            path = currentTitle():match('~%S+')

            if hs.fs.pathToAbsolute(path .. '/routes/web.php') then
                openInCode(path .. '/routes/web.php')
            end
        end,
        sublime = function()
            root = currentTitle():match('%S+$')
            path = currentTitle():match('^~%S+' .. root)

            if hs.fs.pathToAbsolute(path .. '/routes/web.php') then
                openInSublime(path .. '/routes/web.php')
            end
        end
    })
    :add('T', {notion = 'tasks'})
    :add('E', {
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
    })
    :add('S', {
        atom = function()
            openInSublime('/Users/nathan/Development/Atom/fueling-snippets/snippets')
        end,
        sublime = 'BetterSnippetManager: Edit Snippets'
    })
    :add('Z', {iterm = 'wd fz'})
    :add('B', {
        atom = 'Application: Open Your Keymap',
        sublime = 'Preferences: Key Bindings',
        vscode = 'Preferences: Open Keyboard Shortcuts'
    })
    :add('D', {
        notion = function()
            ks.altCmd('2').shift('2')
        end,
        iterm = 'wd d'
    })
    :add('0', {
        -- Notion: Create text
        notion = function() ks.altCmd('0') end
    })
    :add('1', {
        -- Notion: Create H1 heading
        notion = function() ks.altCmd('1') end,
        sublime = function() ks.escape().shift('i').type('# ') end,
        default = function() ks.cmd('left').type('# ') end
    })
    :add('2', {
        -- Notion: Create H2 heading
        notion = function() ks.altCmd('2') end,
        sublime = function() ks.escape().shift('i').type('## ') end,
        default = function() ks.cmd('left').type('## ') end
    })
    :add('3', {
        -- Notion: Create H3 heading
        notion = function() ks.altCmd('3') end,
        sublime = function() ks.escape().shift('i').type('### ') end,
        default = function() ks.cmd('left').type('### ') end
    })
    :add('4', {
        -- Notion: Create to-do checkbox
        notion = function() ks.altCmd('4') end,
        sublime = function()
            if titleContains('.todo') then
                -- Sublime: Create to-do checkbox
                ks.cmd('i')
            else
                ks.escape().shift('i').type('- ')
            end
        end,
        default = function() ks.cmd('left').type('- ') end
    })
    :add('5', {
        -- Notion: Create bulleted list
        notion = function() ks.altCmd('5') end,
        sublime = function() ks.escape().shift('i').type('- ') end,
        default = function() ks.cmd('left').type('- ') end
    })
    :add('6', {
        -- Notion: Create numbered list
        notion = function() ks.altCmd('6') end,
        sublime = function() ks.escape().shift('i').type('1. ') end,
        default = function() ks.cmd('left').type('1. ') end
    })
    :add('7', {
        -- Notion: Create toggle list
        notion = function() ks.altCmd('7') end
    })
    :add('8', {
        -- Notion: Create code block
        notion = function() ks.altCmd('8') end
    })
