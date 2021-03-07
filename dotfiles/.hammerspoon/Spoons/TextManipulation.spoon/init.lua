local TextManipulation = {}
TextManipulation.__index = TextManipulation

TextManipulation.wrapperKeyLookup = {
    t = {mods = {}, key = 't'}, -- t -> tag
    s = {mods = {}, key = "'"}, -- s -> single quotes
    d = {mods = {'shift'}, key = "'"}, -- d -> double quotes
    z = {mods = {}, key = 'z'}, -- z -> back ticks
    f = {mods = {'shift'}, key = '9'}, -- f -> parenthesis
    c = {mods = {'shift'}, key = '['}, -- c -> braces
    b = {mods = {}, key = '['}, -- b -> brackets
}

TextManipulation.vimEnabled = true

Modal.addWithMenubar({
    key = 'TextManipulation:vimDisabled',
    title = 'Vim Text Manipulation Disabled',
    shortcuts = {
        ['return'] = function()
            if inCodeEditor() then
                Modal.exit()
                hs.eventtap.keyStroke({}, 'return', 0)
            end
        end
    },
    entered = function()
        TextManipulation.vimEnabled = false
    end,
    exited = function()
        TextManipulation.vimEnabled = true
    end,
})

function TextManipulation.canManipulateWithVim()
    if not TextManipulation.vimEnabled or isAlfredVisible() then
        return false
    end

    if appIncludes({atom, sublime}) then
        return true
    end

    return false
end

function TextManipulation.disableVim()
    Modal.enter('TextManipulation:vimDisabled')
end

hs.urlevent.bind('text-disableVim', function(eventName, params)
    TextManipulation.disableVim()
end)

return TextManipulation
