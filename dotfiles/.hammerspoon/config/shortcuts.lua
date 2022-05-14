Shortcuts
    :add('W', {slack = function()
        fn.Slack.react(':wave:')
    end})
    :add('R', {
        slack = fn.Slack.react,
        vscode = function()
            if is.malachor() then
                return fn.custom.openClientTasks()
            end

            local path = currentTitle():match('~%S+')

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
            if is.malachor() then
                return fn.custom.openEod()
            elseif is.hammerspoon() then
                md.Hyper.open()
                ks.type('Helpers/')

                return
            end

            local path = currentTitle():match('~%S+')

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
            if is.malachor() then
                return fn.custom.openDigitalCreativity()
            elseif is.hammerspoon() then
                md.Hyper.open()
                ks.type('Modes/')
            else
                md.Hyper.open()
                ks.type('app/Models/')
            end
        end,
    })
    :add('C', {
        vscode = function()
            if is.hammerspoon() then
                md.Hyper.open()
                ks.type('Commands/')
            else
                md.Hyper.open()
                ks.type('app/Http/Controllers/')
            end
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
