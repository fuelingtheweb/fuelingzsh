local OpenIn = {}
OpenIn.__index = OpenIn

Modal.add({
    key = 'OpenIn',
    title = 'Open In',
    items = {
        r = {name = 'VS Code', method = 'inCode'},
        c = {name = 'Sublime Merge', method = 'inSublimeMerge'},
        e = {name = 'Sublime', method = 'inSublime'},
        q = {name = 'Atom', method = 'inAtom'},
        g = {name = 'Chrome', method = 'inChrome'},
        v = {name = 'TablePlus', method = 'inTablePlus'},
        x = {name = 'Finder', method = 'inFinder'},
        w = {name = 'Tinkerwell', method = 'inTinkerwell'},
    },
    callback = function(item)
        Modal.exit()

        OpenIn[item.method]()

        hs.timer.doAfter(
            is.iterm() and 2 or 0.5,
            function()
                md.WindowManager.moveTo('maximize')
            end
        )
    end,
})

function OpenIn.inSublimeMerge()
    if is.iterm() then
        ks.type('smerge .').enter()
    else
        local path = currentTitle():match('~%S+')

        if path then
            hs.execute('/usr/local/bin/smerge "' .. path .. '"')
        end
    end

    hs.timer.doAfter(0.5, function()
        hs.application.open(sublimeMerge)
    end)
end

function OpenIn.inSublime()
    if is.iterm() then
        ks.type('st.').enter()
    else
        path = currentTitle():match('~%S+')

        if is.In(atom, vscode) then
            md.Yank.relativeFilePath()

            hs.timer.doAfter(0.2, function()
                filePath = hs.pasteboard.getContents()

                if path and filePath then
                    fn.Sublime.open(path .. '/' .. filePath)
                end
            end)
        end

        if not path then
            return
        end

        fn.Sublime.open(path)
    end
end

function OpenIn.inAtom()
    if is.iterm() then
        ks.type('atom .').enter()
    else
        fn.Alfred.run('projects', 'com.fuelingtheweb.commands')
    end
end

function OpenIn.inCode()
    if is.iterm() then
        ks.type('code .').enter()
    else
        path = currentTitle():match('~%S+')

        if is.In(atom) then
            md.Yank.relativeFilePath()

            hs.timer.doAfter(0.2, function()
                filePath = hs.pasteboard.getContents()

                if path and filePath then
                    fn.Code.open(path .. '/' .. filePath)
                end
            end)
        end

        if not path then
            return
        end

        fn.Code.open(path)
    end
end

function OpenIn.inChrome()
    text = getSelectedText()

    if is.notIn(atom, sublime) and text then
        fn.Chrome.searchGoogle(text)
    elseif is.chrome() then
        fn.Chrome.copyUrl()
        fn.Chrome.open(getSelectedText())
    else
        ProjectManager.openUrlForCurrent()
    end
end

function OpenIn.inTablePlus()
    if not ProjectManager:openDatabaseForCurrent() then
        fn.Alfred.run('tableplus', 'com.chrisrenga.tableplus')
    end

    hs.timer.doAfter(0.5, function() md.Hyper.open() end)
end

function OpenIn.inFinder()
    if is.iterm() then
        ks.type('o.').enter()
    else
        path = currentTitle():match('~%S+')

        if not path then
            return
        end

        if is.In(atom) then
            hs.execute('open ' .. path)
        else
            hs.execute('open -R ' .. path)
        end
    end
end

function OpenIn.inTinkerwell()
    if is.iterm() then
        return ks.type('tinkerwell .').enter()
    end

    path = currentTitle():match('~%S+')

    if path then
        executeFromFuelingZsh('tinkerwell "' .. path .. '"')
    end
end

return OpenIn
