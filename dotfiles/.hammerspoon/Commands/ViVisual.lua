local ViVisual = {}
ViVisual.__index = ViVisual

function ViVisual.beginSelectingForward()
    if is.notVimMode() then
        return
    end

    if is.vscode() then
        ks.ctrl('v')
    elseif is.In(atom) then
        ks.super('v').key('l')
    elseif is.sublime() then
        ks.super('v')
    end
end

function ViVisual.beginSelectingBackward()
    if is.notVimMode() then
        return
    end

    if is.vscode() then
        ks.ctrl('v')
    elseif is.codeEditor() then
        ks.super('v').key('h')
    end
end


return ViVisual
