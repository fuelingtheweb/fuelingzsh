Modal.add({
    key = 'CodeSnippets:extraSnippets',
    title = 'Extra Snippets',
    items = {
        t = {
            key = 'laravelTests',
            title = 'Laravel Tests',
            items = {
                r = {value = 'use RefreshDatabase;', callback = function()
                    spoon.CodeMode.addUseStatement()
                end},
            }
        },
        m = {
            key = 'laravelModel',
            title = 'Laravel Model',
            items = {
                g = 'protected $guarded = [];',
            }
        },
    },
    callback = function(item)
        Modal.exit()

        if isTable(item) then
            insertText(item.value)

            if item.callback then
                fastKeyStroke('left')
                item.callback()
            end
        else
            insertText(item)
        end
    end,
})
