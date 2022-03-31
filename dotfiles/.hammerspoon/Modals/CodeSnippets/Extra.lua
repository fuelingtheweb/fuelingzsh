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

        if is.Table(item) then
            ks.type(item.value)

            if item.callback then
                ks.left()
                item.callback()
            end
        else
            ks.type(item)
        end
    end
})

return mdl
