local TextManipulation = {}
TextManipulation.__index = TextManipulation

hs.loadSpoon('ModalMgr')
TextManipulation.vimEnabled = true
TextManipulation.menuBar = hs.menubar.newWithPriority(hs.menubar.priorities['system']):setTitle(''):returnToMenuBar();
TextManipulation.modalKey = 'DisabledVimTextManipulation'

spoon.ModalMgr:new(TextManipulation.modalKey)
TextManipulation.modal = spoon.ModalMgr.modal_list[TextManipulation.modalKey]

TextManipulation.modal:bind('', 'escape', nil, function()
    spoon.ModalMgr:deactivate({TextManipulation.modalKey})
end)
TextManipulation.modal.entered = function()
    TextManipulation.vimEnabled = false
    TextManipulation.menuBar:setTitle('Vim Text Manipulated Disabled')
end
TextManipulation.modal.exited = function()
    TextManipulation.vimEnabled = true
    TextManipulation.menuBar:setTitle('')
end

function TextManipulation.canManipulateWithVim()
    return TextManipulation.vimEnabled and appIncludes({atom, sublime})
end

hs.urlevent.bind('text-disableVim', function(eventName, params)
    spoon.ModalMgr:deactivateAll()
    spoon.ModalMgr:activate({TextManipulation.modalKey}, '#FFFFFF', false)
end)

hs.urlevent.bind('dialogCase', function(eventName, params)
    triggerAlfredWorkflow('case-dialog', 'com.fuelingtheweb.commands', params.to)
end)

hs.urlevent.bind('changeCaseAndConvert', function(eventName, params)
    result = trim(hs.execute('/Users/nathan/.nvm/versions/node/v12.4.0/bin/node /Users/nathan/.fuelingzsh/bin/change-case/bin/index.js "' .. params.to .. '" "' .. params.text .. '"'))
    hs.eventtap.keyStrokes(result)
end)

hs.urlevent.bind('changeCase', function(eventName, params)
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({'ctrl', 'alt', 'cmd'}, 'c', 0)
        hs.eventtap.keyStroke({'ctrl', 'alt'}, params.key, 0)
    else
        text = getSelectedText()

        if not text then
            hs.eventtap.keyStroke({'shift', 'alt'}, 'left', 0)
            text = getSelectedText()
        end

        result = trim(hs.execute('/Users/nathan/.nvm/versions/node/v12.4.0/bin/node /Users/nathan/.fuelingzsh/bin/change-case/bin/index.js "' .. params.to .. '" "' .. text .. '"'))
        hs.eventtap.keyStrokes(result)
    end
end)

hs.urlevent.bind('yank-toEndOfWord', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'y', 0)
        hs.eventtap.keyStroke({}, 'e', 0)
    else
        hs.eventtap.keyStroke({'shift', 'alt'}, 'right', 0)
        hs.eventtap.keyStroke({'cmd'}, 'c', 0)
        hs.eventtap.keyStroke({}, 'left', 0)
    end
end)

hs.urlevent.bind('yank-relativeFilePath', function()
    if appIs(atom) then
        hs.eventtap.keyStroke({'shift', 'ctrl', 'alt', 'cmd'}, 'y', 0)
        hs.eventtap.keyStroke({'shift', 'ctrl', 'alt', 'cmd'}, 'r', 0)
    elseif appIs(sublime) then
        hs.eventtap.keyStroke({'shift', 'ctrl', 'alt', 'cmd'}, 'y', 0)
    end
end)

hs.urlevent.bind('yank-word', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'y', 0)
        hs.eventtap.keyStroke({}, 'i', 0)
        hs.eventtap.keyStroke({}, 'w', 0)
    else
        hs.eventtap.keyStroke({'shift', 'alt'}, 'left', 0)
        hs.eventtap.keyStroke({'cmd'}, 'c', 0)
        hs.eventtap.keyStroke({}, 'right', 0)
    end
end)

hs.urlevent.bind('yank-toEndOfLine', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'y', 0)
        hs.eventtap.keyStroke({'shift'}, '4', 0)
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'right', 0)
        hs.eventtap.keyStroke({'cmd'}, 'c', 0)
        hs.eventtap.keyStroke({}, 'left', 0)
    end
end)

hs.urlevent.bind('yank-toBeginningOfLine', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'left', 0)
        hs.eventtap.keyStroke({}, 'y', 0)
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'left', 0)
        hs.eventtap.keyStroke({'cmd'}, 'c', 0)
        hs.eventtap.keyStroke({}, 'right', 0)
    end
end)

hs.urlevent.bind('yank-line', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'y', 0)
        hs.eventtap.keyStroke({}, 'y', 0)
    else
        hs.eventtap.keyStroke({'cmd'}, 'left', 0)
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'right', 0)
        hs.eventtap.keyStroke({'cmd'}, 'c', 0)
        hs.eventtap.keyStroke({}, 'right', 0)
    end
end)

hs.urlevent.bind('yank-character', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'y', 0)
        hs.eventtap.keyStroke({}, 'l', 0)
    else
        hs.eventtap.keyStroke({'shift'}, 'left', 0)
        hs.eventtap.keyStroke({'cmd'}, 'c', 0)
        hs.eventtap.keyStroke({}, 'right', 0)
    end
end)

hs.urlevent.bind('yank-all', function()
    hs.eventtap.keyStroke({'cmd'}, 'A', 0)
    hs.eventtap.keyStroke({'cmd'}, 'C', 0)
    hs.eventtap.keyStroke({}, 'Right', 0)
end)

hs.urlevent.bind('paste-toEndOfWord', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'v', 0)
        hs.eventtap.keyStroke({}, 'e', 0)
        hs.eventtap.keyStroke({}, 'p', 0)
    else
        hs.eventtap.keyStroke({'shift', 'alt'}, 'right', 0)
        hs.eventtap.keyStroke({'cmd'}, 'v', 0)
    end
end)

hs.urlevent.bind('paste-word', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'v', 0)
        hs.eventtap.keyStroke({}, 'i', 0)
        hs.eventtap.keyStroke({}, 'w', 0)
        hs.eventtap.keyStroke({}, 'p', 0)
    else
        hs.eventtap.keyStroke({'shift', 'alt'}, 'left', 0)
        hs.eventtap.keyStroke({'cmd'}, 'v', 0)
    end
end)

hs.urlevent.bind('paste-toEndOfLine', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'v', 0)
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'right', 0)
        hs.eventtap.keyStroke({}, 'p', 0)
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'right', 0)
        hs.eventtap.keyStroke({'cmd'}, 'v', 0)
    end
end)

hs.urlevent.bind('paste-toBeginningOfLine', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'left', 0)
        hs.eventtap.keyStroke({}, 'p', 0)
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'left', 0)
        hs.eventtap.keyStroke({'cmd'}, 'v', 0)
    end
end)

hs.urlevent.bind('paste-line', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({'shift'}, 'v', 0)
        hs.eventtap.keyStroke({}, 'p', 0)
    else
        hs.eventtap.keyStroke({'cmd'}, 'left', 0)
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'right', 0)
        hs.eventtap.keyStroke({'cmd'}, 'v', 0)
    end
end)

hs.urlevent.bind('paste-character', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'v', 0)
        hs.eventtap.keyStroke({}, 'p', 0)
    else
        hs.eventtap.keyStroke({'shift'}, 'left', 0)
        hs.eventtap.keyStroke({'cmd'}, 'v', 0)
    end
end)

hs.urlevent.bind('change-toEndOfWord', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'c', 0)
        hs.eventtap.keyStroke({}, 'e', 0)
    else
        hs.eventtap.keyStroke({'shift', 'alt'}, 'right', 0)
        hs.eventtap.keyStroke({}, 'delete', 0)
    end
end)

hs.urlevent.bind('change-word', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'c', 0)
        hs.eventtap.keyStroke({}, 'i', 0)
        hs.eventtap.keyStroke({}, 'w', 0)
    else
        hs.eventtap.keyStroke({'alt'}, 'delete', 0)
    end
end)

hs.urlevent.bind('change-toEndOfLine', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({'shift'}, 'c', 0)
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'right', 0)
        hs.eventtap.keyStroke({}, 'delete', 0)
    end
end)

hs.urlevent.bind('change-toBeginningOfLine', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'left', 0)
        hs.eventtap.keyStroke({}, 'c', 0)
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'left', 0)
        hs.eventtap.keyStroke({}, 'delete', 0)
    end
end)

hs.urlevent.bind('change-line', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'c', 0)
        hs.eventtap.keyStroke({}, 'c', 0)
    else
        hs.eventtap.keyStroke({'cmd'}, 'left', 0)
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'right', 0)
        hs.eventtap.keyStroke({}, 'delete', 0)
    end
end)

hs.urlevent.bind('change-character', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'v', 0)
        hs.eventtap.keyStroke({}, 'c', 0)
    else
        hs.eventtap.keyStroke({}, 'delete', 0)
    end
end)

hs.urlevent.bind('destroy-toEndOfWord', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'd', 0)
        hs.eventtap.keyStroke({}, 'e', 0)
    else
        hs.eventtap.keyStroke({'shift', 'alt'}, 'right', 0)
        hs.eventtap.keyStroke({}, 'delete', 0)
    end
end)

hs.urlevent.bind('destroy-word', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'd', 0)
        hs.eventtap.keyStroke({}, 'i', 0)
        hs.eventtap.keyStroke({}, 'w', 0)
    elseif appIs(iterm) then
        hs.eventtap.keyStroke({'ctrl'}, 'w', 0)
    else
        hs.eventtap.keyStroke({'alt'}, 'delete', 0)
    end
end)

hs.urlevent.bind('destroy-toEndOfLine', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({'shift'}, 'd', 0)
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'right', 0)
        hs.eventtap.keyStroke({}, 'delete', 0)
    end
end)

hs.urlevent.bind('destroy-toBeginningOfLine', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'left', 0)
        hs.eventtap.keyStroke({}, 'd', 0)
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'left', 0)
        hs.eventtap.keyStroke({}, 'delete', 0)
    end
end)

hs.urlevent.bind('destroy-line', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'd', 0)
        hs.eventtap.keyStroke({}, 'd', 0)
    else
        hs.eventtap.keyStroke({'cmd'}, 'left', 0)
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'right', 0)
        hs.eventtap.keyStroke({}, 'delete', 0)
    end
end)

hs.urlevent.bind('destroy-character', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'x', 0)
    else
        hs.eventtap.keyStroke({}, 'delete', 0)
    end
end)

hs.urlevent.bind('select-inside-word', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'v', 0)
        hs.eventtap.keyStroke({}, 'i', 0)
        hs.eventtap.keyStroke({}, 'w', 0)
    else
        hs.eventtap.keyStroke({'shift', 'alt'}, 'left', 0)
    end
end)

hs.urlevent.bind('select-inside-line', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({'shift'}, 'v', 0)
    else
        hs.eventtap.keyStroke({'cmd'}, 'left', 0)
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'right', 0)
    end
end)

hs.urlevent.bind('select-inside-character', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'v', 0)
    else
        hs.eventtap.keyStroke({'shift'}, 'left', 0)
    end
end)

hs.urlevent.bind('select-until-endOfWord', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'v', 0)
        hs.eventtap.keyStroke({}, 'e', 0)
    else
        hs.eventtap.keyStroke({'shift', 'alt'}, 'right', 0)
    end
end)

hs.urlevent.bind('select-until-nextWord', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({}, 'v', 0)
        hs.eventtap.keyStroke({}, 'w', 0)
    else
        hs.eventtap.keyStroke({'shift', 'alt'}, 'right', 0)
        hs.eventtap.keyStroke({'shift', 'alt'}, 'right', 0)
    end
end)

hs.urlevent.bind('select-until-endOfLine', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'right', 0)
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'right', 0)
    end
end)

hs.urlevent.bind('select-until-beginningOfLine', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({}, 'escape', 0)
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'left', 0)
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'left', 0)
    end
end)

hs.urlevent.bind('select-until-previousBlock', function()
    if TextManipulation.canManipulateWithVim() then
        hs.eventtap.keyStroke({'shift'}, 'v', 0)
        hs.eventtap.keyStroke({'shift', 'ctrl', 'alt', 'cmd'}, 'v', 0)
        hs.eventtap.keyStroke({'shift'}, '[', 0)
    else
        hs.eventtap.keyStroke({'shift', 'cmd'}, 'left', 0)
    end
end)

return TextManipulation
