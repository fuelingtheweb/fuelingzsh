class Simlayer:
    def __init__(self, title, name, modifier, keys = '', custom = ''):
        self.title = title
        self.name = name
        self.modifier = modifier
        self.keys = keys
        self.custom = custom
        self.primary = False
        self.available = False

    def setAsPrimary(self):
        self.primary = True

        return self

    def setAsAvailable(self):
        self.available = True

        return self

    def isNotPrimary(self):
        return not self.primary

    def definition(self):
        if self.available:
            return "%s; %s" % (self.indent(2), self.modifier)

        return "%s:%s {:key :%s}" % (self.indent(2), self.name, self.modifier)

    def ruleset(self):
        if self.available:
            return ''

        return """%s{
            :des \"%s\"
            :rules [:%s
                %s
            ]
        }""" % (self.indent(2), self.title, self.name, self.getRules())

    def getRules(self):
        rules = ''

        for key in self.getKeys():
            if key == self.modifier:
                continue

            rules += "[:%s [:!STC%s :!!%s]]\n%s" % (key, self.newKey(self.modifier), self.newKey(key), self.indent(4))

        if self.custom:
            rules += self.custom.strip()

        return rules.rstrip()

    def getKeys(self):
        keys = self.keys

        if keys == 'all':
            keys = '1,2,3,4,5,6,7,8,9,0,tab,q,w,e,r,t,y,u,i,o,p,open_bracket,close_bracket,caps_lock,a,s,d,f,g,h,j,k,l,semicolon,quote,return_or_enter,left_shift,z,x,c,v,b,n,m,comma,period,slash,right_shift,spacebar'
        elif keys == 'all-left':
            keys = 'tab,q,w,e,r,t,caps_lock,a,s,d,f,g,left_shift,z,x,c,v,b,spacebar'
        elif keys == 'all-right':
            keys = 'y,u,i,o,p,open_bracket,close_bracket,h,j,k,l,semicolon,quote,return_or_enter,b,n,m,comma,period,slash,right_shift,spacebar'

        return keys.split(',')

    def newKey(self, key):
        keys = {
            'o': 'f13',
            'n': 'f14',
            'left_shift': 'f15',
            'caps_lock': 'f16',
            'w': 'f17',
            'comma': 'f18',
            'period': 'f19',
            'slash': 'f20'
        }

        return keys.get(key) or key

    def indent(self, count):
        return '    ' * count

