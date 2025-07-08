local TextManipulation = {}
TextManipulation.__index = TextManipulation

TextManipulation.vimEnabled = true

Modal.add({
    key = 'TextManipulation:vimDisabled',
    title = 'Vi Mode Disabled',
    defaults = false,
    items = {
        ['return'] = function()
            Modal.exit()
            ks.enter()
        end
    },
    entered = function() TextManipulation.vimEnabled = false end,
    exited = function() TextManipulation.vimEnabled = true end,
})

function TextManipulation.canManipulateWithVim()
    if not TextManipulation.vimEnabled or fn.Alfred.visible() then
        return false
    end

    if is.codeEditor() or is.obsidian() then
        return true
    end

    return false
end

function TextManipulation.disableVim()
    Modal.enter('TextManipulation:vimDisabled')
end

return TextManipulation
