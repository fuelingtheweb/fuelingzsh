Modal.add({
    key = 'CodeSnippets:callFunction',
    title = 'Call Function',
    items = {
        ['.'] = 'exit',
        w = {
            key = 'laravelWhere',
            title = 'Laravel Where',
            items = {
                w = {method = 'where'},
                f = {method = 'firstWhere'},
                h = {method = 'whereHas', extra = 'query'},
                c = {method = 'whereColumn'},
            }
        },
        r = {
            key = 'laravelRule',
            title = 'Laravel Rule',
            items = {
                e = {method = 'exists'},
                u = {method = 'unique'},
                ['return'] = {method = 'Rule::', extra = 'start'},
            }
        },
        o = {
            key = 'laravelOrWhere',
            title = 'Laravel orWhere',
            items = {
                w = {method = 'orWhere'},
                h = {method = 'orWhereHas', extra = 'query'},
            }
        },
        s = {
            key = 'laravelStr',
            title = 'Laravel Str',
            items = {
                p = {method = 'plural'},
                ['return'] = {method = 'Str::', extra = 'start'},
            }
        },
        d = {
            key = 'laravelDb',
            title = 'Laravel DB',
            items = {
                q = {method = 'query'},
                w = {method = 'where'},
                t = {method = 'take'},
                u = {method = 'update'},
                o = {method = 'orderBy'},
                s = {method = 'select'},
                d = {method = 'orderByDesc'},
                f = {method = 'first'},
                g = {method = 'get'},
                h = {method = 'has'},
                j = {method = 'join'},
            }
        },
        f = {
            key = 'laravelFactory',
            title = 'Laravel Factory',
            items = {
                f = {method = 'for'},
                h = {method = 'has'},
                ['return'] = {method = 'factory'},
            }
        },
        g = {
            key = 'general',
            title = 'General',
            items = {
                w = {method = 'when'},
                e = {method = 'empty'},
                p = {method = 'pluck'},
                [';'] = {method = 'static'},
            }
        },
        l = {
            key = 'laravelHelpers',
            title = 'Laravel Helpers',
            items = {
                q = {method = 'request'},
                w = {method = 'now'},
                t = {method = 'route'},
                u = {method = 'auth()->user'},
                o = {method = 'old'},
                a = {method = 'auth'},
                s = {method = 'session'},
                d = {method = 'redirect'},
                c = {method = 'collect'},
                v = {method = 'view'},
                n = {method = 'config'},
            }
        },
        c = {
            key = 'laravelCollection',
            title = 'Laravel Collection',
            items = {
                e = {method = 'each'},
                r = {method = 'reduce'},
                y = {method = 'isEmpty'},
                u = {method = 'isNotEmpty'},
                f = {method = 'filter'},
                l = {method = 'count'},
                c = {method = 'contains'},
                m = {method = 'map'},
            }
        },
        m = {
            key = 'laravelModel',
            title = 'Laravel Model',
            items = {
                q = {method = '::query'},
                r = {method = 'refresh'},
                a = {method = '::all'},
                f = {method = 'fresh'},
                c = {method = 'create'},
            }
        },
    },
    callback = function(item)
        spoon.CodeSnippets.handleCallFunction(item)
    end,
})
