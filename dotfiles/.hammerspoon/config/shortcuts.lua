Shortcuts
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
    })
    :add('S', {
        atom = function()
            openInSublime('/Users/nathan/Development/Atom/fueling-snippets/snippets')
        end,
        sublime = 'BetterSnippetManager: Edit Snippets',
    })
    :add('Z', {iterm = 'wd fz'})
    :add('H', {
        notion = 'home',
        iterm = 'hc',
    })
    :add('M', {
        atom = 'Application: Open Your Keymap',
        sublime = 'Preferences: Key Bindings',
    })
    :add('D', {
        notion = function()
            hs.eventtap.keyStroke({'alt', 'cmd'}, '2')
            hs.eventtap.keyStroke({'shift'}, '2')
        end,
        iterm = 'wd d',
    })
    :add('0', {
        notion = function()
            -- Notion: Create text
            hs.eventtap.keyStroke({'alt', 'cmd'}, '0')
        end,
    })
    :add('1', {
        notion = function()
            -- Notion: Create H1 heading
            hs.eventtap.keyStroke({'alt', 'cmd'}, '1')
        end,
        sublime = function()
            hs.eventtap.keyStroke({}, 'escape', 0)
            hs.eventtap.keyStroke({'shift'}, 'i', 0)
            hs.eventtap.keyStrokes('# ')
        end,
        default = function()
            hs.eventtap.keyStroke({'cmd'}, 'left', 0)
            hs.eventtap.keyStrokes('# ')
        end,
    })
    :add('2', {
        notion = function()
            -- Notion: Create H2 heading
            hs.eventtap.keyStroke({'alt', 'cmd'}, '2')
        end,
        sublime = function()
            hs.eventtap.keyStroke({}, 'escape', 0)
            hs.eventtap.keyStroke({'shift'}, 'i', 0)
            hs.eventtap.keyStrokes('## ')
        end,
        default = function()
            hs.eventtap.keyStroke({'cmd'}, 'left', 0)
            hs.eventtap.keyStrokes('## ')
        end,
    })
    :add('3', {
        notion = function()
            -- Notion: Create H3 heading
            hs.eventtap.keyStroke({'alt', 'cmd'}, '3')
        end,
        sublime = function()
            hs.eventtap.keyStroke({}, 'escape', 0)
            hs.eventtap.keyStroke({'shift'}, 'i', 0)
            hs.eventtap.keyStrokes('### ')
        end,
        default = function()
            hs.eventtap.keyStroke({'cmd'}, 'left', 0)
            hs.eventtap.keyStrokes('### ')
        end,
    })
    :add('4', {
        notion = function()
            -- Notion: Create to-do checkbox
            hs.eventtap.keyStroke({'alt', 'cmd'}, '4')
        end,
        sublime = function()
            if titleContains('.todo') then
                -- Sublime: Create to-do checkbox
                hs.eventtap.keyStroke({'cmd'}, 'i')
            else
                hs.eventtap.keyStroke({}, 'escape', 0)
                hs.eventtap.keyStroke({'shift'}, 'i', 0)
                hs.eventtap.keyStrokes('- ')
            end
        end,
        default = function()
            hs.eventtap.keyStroke({'cmd'}, 'left', 0)
            hs.eventtap.keyStrokes('- ')
        end,
    })
    :add('5', {
        notion = function()
            -- Notion: Create bulleted list
            hs.eventtap.keyStroke({'alt', 'cmd'}, '5')
        end,
        sublime = function()
            hs.eventtap.keyStroke({}, 'escape', 0)
            hs.eventtap.keyStroke({'shift'}, 'i', 0)
            hs.eventtap.keyStrokes('- ')
        end,
        default = function()
            hs.eventtap.keyStroke({'cmd'}, 'left', 0)
            hs.eventtap.keyStrokes('- ')
        end,
    })
    :add('6', {
        notion = function()
            -- Notion: Create numbered list
            hs.eventtap.keyStroke({'alt', 'cmd'}, '6')
        end,
        sublime = function()
            hs.eventtap.keyStroke({}, 'escape', 0)
            hs.eventtap.keyStroke({'shift'}, 'i', 0)
            hs.eventtap.keyStrokes('1. ')
        end,
        default = function()
            hs.eventtap.keyStroke({'cmd'}, 'left', 0)
            hs.eventtap.keyStrokes('1. ')
        end,
    })
    :add('7', {
        notion = function()
            -- Notion: Create toggle list
            hs.eventtap.keyStroke({'alt', 'cmd'}, '7')
        end,
    })
    :add('8', {
        notion = function()
            -- Notion: Create code block
            hs.eventtap.keyStroke({'alt', 'cmd'}, '8')
        end,
    })
