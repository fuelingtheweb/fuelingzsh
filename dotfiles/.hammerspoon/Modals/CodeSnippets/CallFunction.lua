local mdl = {}
mdl.__index = mdl

Modal.add({
    key = 'CodeSnippets:callFunction',
    title = 'Call Function',
    items = {
        ['.'] = 'exit',
        w = {
            key = 'laravelWhere',
            title = 'Laravel Where',
            items = {
                w = {name = 'where', method = 'where'},
                f = {name = 'firstWhere', method = 'firstWhere'},
                h = {name = 'whereHas', method = 'whereHas', extra = 'query'},
                c = {name = 'whereColumn', method = 'whereColumn'},
            }
        },
        r = {
            key = 'laravelRule',
            title = 'Laravel Rule',
            items = {
                e = {name = 'exists', method = 'exists'},
                u = {name = 'unique', method = 'unique'},
                ['return'] = {name = 'Rule::', method = 'Rule::', extra = 'start'},
            }
        },
        t = {
            key = 'test',
            title = 'Test',
            items = {
                l = {name = 'assertCount', method = 'assertCount'},
                ["'"] = {name = 'assertEquals', method = 'assertEquals'},
            }
        },
        o = {
            key = 'laravelOrWhere',
            title = 'Laravel orWhere',
            items = {
                w = {name = 'orWhere', method = 'orWhere'},
                h = {name = 'orWhereHas', method = 'orWhereHas', extra = 'query'},
            }
        },
        s = {
            key = 'laravelStr',
            title = 'Laravel Str',
            items = {
                p = {name = 'plural', method = 'plural'},
                ['return'] = {name = 'Str::', method = 'Str::', extra = 'start'},
            }
        },
        d = {
            key = 'laravelDb',
            title = 'Laravel DB',
            items = {
                q = {name = 'query', method = 'query'},
                w = {name = 'where', method = 'where'},
                t = {name = 'take', method = 'take'},
                u = {name = 'update', method = 'update'},
                o = {name = 'orderBy', method = 'orderBy'},
                s = {name = 'select', method = 'select'},
                d = {name = 'orderByDesc', method = 'orderByDesc'},
                f = {name = 'first', method = 'first'},
                g = {name = 'get', method = 'get'},
                h = {name = 'has', method = 'has'},
                j = {name = 'join', method = 'join'},
            }
        },
        f = {
            key = 'laravelFactory',
            title = 'Laravel Factory',
            items = {
                f = {name = 'for', method = 'for'},
                h = {name = 'has', method = 'has'},
                ['return'] = {name = 'factory', method = 'factory'},
            }
        },
        g = {
            key = 'general',
            title = 'General',
            items = {
                w = {name = 'when', method = 'when'},
                e = {name = 'empty', method = 'empty'},
                p = {name = 'pluck', method = 'pluck'},
                [';'] = {name = 'static', method = 'static'},
            }
        },
        l = {
            key = 'laravelHelpers',
            title = 'Laravel Helpers',
            items = {
                q = {name = 'request', method = 'request'},
                w = {name = 'now', method = 'now'},
                t = {name = 'route', method = 'route'},
                u = {name = 'auth()->user', method = 'auth()->user'},
                o = {name = 'old', method = 'old'},
                a = {name = 'auth', method = 'auth'},
                s = {name = 'session', method = 'session'},
                d = {name = 'redirect', method = 'redirect'},
                c = {name = 'collect', method = 'collect'},
                v = {name = 'view', method = 'view'},
                n = {name = 'config', method = 'config'},
            }
        },
        c = {
            key = 'laravelCollection',
            title = 'Laravel Collection',
            items = {
                e = {name = 'each', method = 'each'},
                r = {name = 'reduce', method = 'reduce'},
                y = {name = 'isEmpty', method = 'isEmpty'},
                u = {name = 'isNotEmpty', method = 'isNotEmpty'},
                a = {name = 'all', method = 'all'},
                f = {name = 'filter', method = 'filter'},
                l = {name = 'count', method = 'count'},
                c = {name = 'contains', method = 'contains'},
                v = {name = 'values', method = 'values'},
                m = {name = 'map', method = 'map'},
                [','] = {name = 'pluck', method = 'pluck'},
                ['.'] = {name = 'push', method = 'push'},
            }
        },
        m = {
            key = 'laravelModel',
            title = 'Laravel Model',
            items = {
                q = {name = '::query', method = '::query'},
                w = {name = 'with', method = 'with'},
                r = {name = 'refresh', method = 'refresh'},
                a = {name = '::all', method = '::all'},
                f = {name = 'fresh', method = 'fresh'},
                c = {name = 'create', method = 'create'},
            }
        },
    },
    callback = function(item)
        md.CodeSnippets.handleCallFunction(item)
    end,
})

return mdl
