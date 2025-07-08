local SideNotes = {}
SideNotes.__index = SideNotes

function SideNotes.isVisible()
    local app = hs.application.find(sideNotes)

    return app and app:isFrontmost()
end

function SideNotes.toggle()
    ks.shiftCtrlAlt('n')
end

function SideNotes.new()
    ks.super('n')
end

function SideNotes.search()
    fn.Alfred.run('search', 'com.apptorium.SideNotes.alfredWorkflow')
end

function SideNotes.next()
    ks.altCmd('down')
end

function SideNotes.previous()
    ks.altCmd('up')
end

function SideNotes.delete()
    ks.altCmd('delete')
end

return SideNotes
