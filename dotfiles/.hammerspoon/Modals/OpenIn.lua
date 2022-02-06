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
    end,
})

function OpenIn.inSublimeMerge()
    if appIs(iterm) then
        return typeAndEnter('smerge .')
    end

    path = currentTitle():match('~%S+')

    if path then
        hs.execute('/usr/local/bin/smerge "' .. path .. '"')
        hs.application.open(sublimeMerge)
    end
end

function OpenIn.inSublime()
    if appIs(iterm) then
        typeAndEnter('st.')
    else
        path = currentTitle():match('~%S+')

        if appIncludes({atom, vscode}) then
            md.Yank.relativeFilePath()

            hs.timer.doAfter(0.2, function()
                filePath = hs.pasteboard.getContents()

                if path and filePath then
                    openInSublime(path .. '/' .. filePath)
                end
            end)
        end

        if not path then
           return;
        end

        openInSublime(path)
    end
end

function OpenIn.inAtom()
    if appIs(iterm) then
        typeAndEnter('atom .')
    else
        triggerAlfredWorkflow('projects', 'com.fuelingtheweb.commands')
    end
end

function OpenIn.inCode()
    if appIs(iterm) then
        typeAndEnter('code .')
    else
        path = currentTitle():match('~%S+')

        if appIs(atom) then
            md.Yank.relativeFilePath()

            hs.timer.doAfter(0.2, function()
                filePath = hs.pasteboard.getContents()

                if path and filePath then
                    openInCode(path .. '/' .. filePath)
                end
            end)
        end

        if not path then
           return;
        end

        openInCode(path)
    end
end

function OpenIn.inChrome()
    text = getSelectedText()
    if not appIncludes({atom, sublime}) and text then
        runGoogleSearch(text)
    elseif appIs(chrome) then
        copyChromeUrl()
        openInChrome(getSelectedText())
    else
        ProjectManager.openUrlForCurrent()
    end
end

function OpenIn.inTablePlus()
    customOpenInTablePlus()

    hs.timer.doAfter(0.2, function()
        md.WindowManager.moveTo('maximize')
        md.Hyper.open()
    end)
end

function OpenIn.inFinder()
    if appIs(iterm) then
        typeAndEnter('o.')
    else
        path = currentTitle():match('~%S+')
        if not path then
           return;
        end
        if appIs(atom) then
            hs.execute('open ' .. path)
        else
            hs.execute('open -R ' .. path)
        end
    end
end

function OpenIn.inTinkerwell()
    if appIs(iterm) then
        return typeAndEnter('tinkerwell .')
    end

    path = currentTitle():match('~%S+')

    if path then
        executeFromFuelingZsh('tinkerwell "' .. path .. '"')
    end
end

return OpenIn
