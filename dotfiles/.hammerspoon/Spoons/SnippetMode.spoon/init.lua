local SnippetMode = {}
SnippetMode.__index = SnippetMode

function SnippetMode.t()
    SnippetMode.this()
end

function SnippetMode.m()
    Pending.run({
        SnippetMode.method,
        SnippetMode.methodMode,
    })
end

SnippetMode.lookup = {
     e = 'elseif',
     d = 'dd',
     i = 'if',
     p = 'property',
     open_bracket = 'echo',
     l = 'log',
     n = 'af',
}

function SnippetMode.handle(key)
    if not appIncludes({atom, sublime}) then
        return
    end

    if SnippetMode[key] then
        SnippetMode[key]()
    elseif SnippetMode.lookup[key] then
        SnippetMode.snippet(SnippetMode.lookup[key])
    end
end

hs.loadSpoon('ModalMgr')
SnippetMode.mode = nil
SnippetMode.menuBar = hs.menubar.newWithPriority(hs.menubar.priorities['system']):setTitle(''):returnToMenuBar();
SnippetMode.modalKey = 'SnippetMethod'

spoon.ModalMgr:new(SnippetMode.modalKey)
SnippetMode.modal = spoon.ModalMgr.modal_list[SnippetMode.modalKey]

SnippetMode.modal:bind('', 'escape', nil, function()
    hs.eventtap.keyStroke({}, 'escape', 0)
    spoon.ModalMgr:deactivate({SnippetMode.modalKey})
end)
SnippetMode.modal.entered = function()
    SnippetMode.mode = 'method'
    SnippetMode.menuBar:setTitle('Snippet: Method')
end
SnippetMode.modal.exited = function()
    SnippetMode.mode = nil
    SnippetMode.menuBar:setTitle('')
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
    SnippetMode.modal:bind('', item.key, nil, function()
        SnippetMode.snippet('method-' .. item.method)
        spoon.ModalMgr:deactivate({SnippetMode.modalKey})
    end)
end)

function SnippetMode.methodMode()
    spoon.ModalMgr:deactivateAll()
    spoon.ModalMgr:activate({SnippetMode.modalKey}, '#FFFFFF', false)
end

function SnippetMode.snippet(name)
    if appIs(sublime) then
        typeAndTab('snippet-' .. name)
    else
        typeAndEnter('snippet-' .. name)
    end
end

function SnippetMode.method()
    if appIs(atom) and titleContains('Test.php') then
        SnippetMode.snippet('method-test')
    elseif appIncludes({atom, sublime}) then
        SnippetMode.snippet('method')
    end
end

function SnippetMode.this()
    if appIs(atom) then
        hs.eventtap.keyStroke({'shift', 'ctrl'}, 'c')

        if stringContains('migrations', hs.pasteboard.getContents()) then
            return hs.eventtap.keyStrokes('$table->')
        end
    end

    if appIncludes({atom, sublime}) then
        SnippetMode.snippet('this')
    end
end

return SnippetMode
