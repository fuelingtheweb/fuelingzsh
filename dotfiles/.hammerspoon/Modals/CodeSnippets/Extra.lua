local mdl = {}
mdl.__index = mdl

Modal.add({
    key = 'CodeSnippets:extraSnippets',
    title = 'Extra Snippets',
    items = {
        t = {
            key = 'laravelTests',
            title = 'Laravel Tests',
            items = {
                r = {
                    value = 'use RefreshDatabase;',
                    callback = function()
                        md.Code.addUseStatement()
                    end
                }
            }
        },
        m = {
            key = 'laravelModel',
            title = 'Laravel Model',
            items = {g = 'protected $guarded = [];'}
        }
    },
    callback = function(item)
        Modal.exit()

        if isTable(item) then
            insertText(item.value)

            if item.callback then
                ks.key('left')
                item.callback()
            end
        else
            insertText(item)
        end
    end
})

return mdl
