local mdl = {}
mdl.__index = mdl

Modal.add({
    key = 'MiscSnippets',
    title = 'Misc Snippets',
    items = {
        c = {
            title = 'c',
            items = {
                y = function()
                    Modal.exit()
                    ks.type(os.date('%Y'))
                end,
                j = {
                    title = 'j',
                    items = {
                        a = 'January',
                        n = 'June',
                        l = 'July',
                    },
                },
                m = {
                    title = 'm',
                    items = {
                        r = 'March',
                        y = 'May',
                        o = 'Monday',
                    },
                },
                a = {
                    title = 'a',
                    items = {
                        p = 'April',
                        u = 'August',
                    },
                },
                f = {
                    title = 'f',
                    items = {
                        e = 'February',
                        r = 'Friday',
                    },
                },
                s = {
                    title = 's',
                    items = {
                        e = 'September',
                        u = 'Sunday',
                        a = 'Saturday',
                    },
                },
                o = {
                    title = 'o',
                    items = {
                        c = 'October',
                    },
                },
                n = {
                    title = 'n',
                    items = {
                        o = 'November',
                    },
                },
                d = {
                    title = 'd',
                    items = {
                        e = 'December',
                    },
                },
                t = {
                    title = 't',
                    items = {
                        u = 'Tuesday',
                        h = 'Thursday',
                    },
                },
                w = {
                    title = 'w',
                    items = {
                        e = 'Wednesday',
                    },
                },
            },
        },
    },
    callback = function(item)
        Modal.exit()
        ks.type(item)
    end
})

return mdl
