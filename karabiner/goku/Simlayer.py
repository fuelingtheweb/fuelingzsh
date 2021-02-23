class Simlayer:
    def __init__(self, title, name, modifier, keys = '', static = True, primary = False, available = False):
        self.title = title
        self.name = name
        self.modifier = modifier
        self.keys = keys
        self.static = static
        self.primary = primary
        self.available = available

    def isNotPrimary(self):
        return not self.primary

    def definition(self):
        if self.available:
            return "%s; %s" % (self.indent(2), self.modifier)

        return "%s:%s {:key :%s}" % (self.indent(2), self.name, self.modifier)

    def ruleset(self):
        keys = self.keys

        if not keys:
            return ''

        rules = ''

        if self.static:
            rules = keys.strip()
        else:
            if keys == 'all':
                keys = 'tab,q,w,e,r,t,y,u,i,o,p,open_bracket,close_bracket,caps_lock,a,s,d,f,g,h,j,k,l,semicolon,quote,return_or_enter,left_shift,z,x,c,v,b,n,m,comma,period,slash,right_shift,spacebar'
            elif keys == 'all-left':
                keys = 'tab,q,w,e,r,t,caps_lock,a,s,d,f,g,left_shift,z,x,c,v,b,spacebar'
            elif keys == 'all-right':
                keys = 'y,u,i,o,p,open_bracket,close_bracket,h,j,k,l,semicolon,quote,return_or_enter,b,n,m,comma,period,slash,right_shift,spacebar'

            for key in keys.split(','):
                if key == self.modifier:
                    continue

                rules += "[:%s [:hs \"handle-karabiner?layer=%s&key=%s\"]]\n%s" % (key, self.name, key, self.indent(4))

        return """%s{
            :des \"%s\"
            :rules [:%s
                %s
            ]
        }""" % (self.indent(2), self.title, self.name, rules.rstrip())

    def indent(self, count):
        return '    ' * count

    @classmethod
    def available(cls, key):
        return cls('', '', key, '', True, False, True)
