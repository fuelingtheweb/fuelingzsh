local mdl = {}
mdl.__index = mdl

Modal.add({
    key = 'CodeSnippets:nested',
    title = 'Nested Snippets',
    items = {
        w = {
            title = 'Livewire',
            items = {
                m = {name = 'wire:model', snippet = 'wire:model="$|$"'},
                c = {name = 'wire:click', snippet = 'wire:click="$|$"'},
                i = {name = 'wire:ignore', snippet = 'wire:ignore'},
                w = {name = 'wire:', snippet = 'wire:'},
                k = {name = 'wire:key', snippet = 'wire:key="$|$"'},
                l = {name = 'wire:loading', snippet = 'wire:loading'},
                t = {name = 'wire:target', snippet = 'wire:target="$|$"'},
            }
        },
    },
    callback = function(item)
        Modal.exit()

        local afterCursor = item.snippet:match('$|$(.*)')
        local cursorPosition = afterCursor and string.len(afterCursor) or 0

        ks.type(item.snippet:gsub('%$|%$', ''))

        if cursorPosition then
            for i = 1, cursorPosition do
                ks.left()
            end
        end
    end,
})

return mdl
