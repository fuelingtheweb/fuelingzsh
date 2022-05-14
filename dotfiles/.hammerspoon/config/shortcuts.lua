Shortcuts
    :add('W', {slack = function()
        fn.Slack.react(':wave:')
    end})
    :add('R', {
        slack = fn.Slack.react,
        vscode = function()
            path = currentTitle():match('~%S+')

            if hs.fs.pathToAbsolute(path .. '/routes/web.php') then
                fn.Code.open(path .. '/routes/web.php')
            end
        end,
    })
    :add('T', {
        vscode = function()
            if is.malachor() then
                return fn.custom.openPlanning()
            end
        end,
    })
    :add('E', {
        vscode = function()
            path = currentTitle():match('~%S+')

            if stringContains('.hammerspoon', path) then
                md.Hyper.open()
                ks.type('Helpers/')

                return
            end

            if hs.fs.pathToAbsolute(path .. '/.env') then
                fn.Code.open(path .. '/.env')
            elseif hs.fs.pathToAbsolute(path .. '/wp-config.php') then
                fn.Code.open(path .. '/wp-config.php')
            end
        end,
    })
    :add('S', {
        vscode = 'Preferences: Configure User Snippets'
    })
    :add('Z', {iterm = 'wd fz'})
    :add('B', {
        vscode = 'Preferences: Open Keyboard Shortcuts'
    })
    :add('D', {
        iterm = 'wd d',
        vscode = function()
            md.Hyper.open()
            ks.type('Modes/')
        end,
    })
    :add('C', {
        vscode = function()
            md.Hyper.open()
            ks.type('Commands/')
        end,
    })
    :add('A', {
        vscode = function()
            if is.hammerspoon() then
                md.Hyper.open()
                ks.type('Apps/')
            end
        end,
    })
    :add('V', {
        vscode = function()
            md.Hyper.open()
            ks.type('resources/views/')
        end,
    })
    :add('SPACEBAR', {
        vscode = 'Preferences: Open Settings (JSON)'
    })
