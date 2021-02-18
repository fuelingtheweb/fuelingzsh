class Simlayer:
    def __init__(self, title, name, modifier, keys = '', static = True, available = False):
        self.title = title
        self.name = name
        self.modifier = modifier
        self.keys = keys
        self.static = static
        self.available = available

    def definition(self):
        if self.available:
            return "%s; %s" % (self.indent(2), self.modifier)

        return "%s:%s {:key :%s}" % (self.indent(2), self.name, self.modifier)

    def ruleset(self):
        if not self.keys:
            return ''

        rules = ''

        if self.static:
            rules = self.keys.strip()
        else:
            for key in self.keys.split(','):
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
        return cls('', '', key, '', True, True)

