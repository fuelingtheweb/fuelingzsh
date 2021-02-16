local Snippet = {}
Snippet.__index = Snippet

hs.loadSpoon('ModalMgr')
Snippet.mode = nil
Snippet.menuBar = hs.menubar.newWithPriority(hs.menubar.priorities['system']):setTitle(''):returnToMenuBar();
Snippet.modalKey = 'SnippetMethod'

spoon.ModalMgr:new(Snippet.modalKey)
Snippet.modal = spoon.ModalMgr.modal_list[Snippet.modalKey]

Snippet.modal:bind('', 'escape', nil, function()
    hs.eventtap.keyStroke({}, 'escape', 0)
    spoon.ModalMgr:deactivate({Snippet.modalKey})
end)
Snippet.modal.entered = function()
    Snippet.mode = 'method'
    Snippet.menuBar:setTitle('Snippet: Method')
end
Snippet.modal.exited = function()
    Snippet.mode = nil
    Snippet.menuBar:setTitle('')
end

methodSnippets = {
    {key = 'n', method = 'construct'},
    {key = 'i', method = 'index'},
    {key = 'c', method = 'create'},
    {key = 's', method = 'store'},
    {key = 'h', method = 'show'},
    {key = 'e', method = 'edit'},
    {key = 'u', method = 'update'},
    {key = 'd', method = 'destroy'},
    {key = 'g', method = 'getter'},
    {key = 'q', method = 'scope'},
    {key = 't', method = 'test-setup'},
    {key = 'o', method = 'protected'},
    {key = 'v', method = 'private'},
    {key = ';', method = 'static'},
}

each(methodSnippets, function(item)
    Snippet.modal:bind('', item.key, nil, function()
        snippet('method-' .. item.method)
        spoon.ModalMgr:deactivate({Snippet.modalKey})
    end)
end)

hs.urlevent.bind('snippet-mode-method', function(eventName, params)
    spoon.ModalMgr:deactivateAll()
    spoon.ModalMgr:activate({Snippet.modalKey}, '#FFFFFF', false)
end)

function snippet(name)
    if appIs(sublime) then
        typeAndTab('snippet-' .. name)
    else
        typeAndEnter('snippet-' .. name)
    end
end

hs.urlevent.bind('snippet-method', function()
    if appIs(atom) and titleContains('Test.php') then
        snippet('method-test')
    elseif appIncludes({atom, sublime}) then
        snippet('method')
    end
end)

hs.urlevent.bind('snippet-this', function()
    if appIs(atom) then
        hs.eventtap.keyStroke({'shift', 'ctrl'}, 'c')

        if stringContains('migrations', hs.pasteboard.getContents()) then
            return hs.eventtap.keyStrokes('$table->')
        end
    end

    if appIncludes({atom, sublime}) then
        snippet('this')
    end
end)

hs.urlevent.bind('snippet', function(eventName, params)
    if appIncludes({atom, sublime}) then
        snippet(params.name)
    end
end)

return Snippet
