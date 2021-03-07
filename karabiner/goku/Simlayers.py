from Simlayer import *

class Simlayers:
    all = []

    def new(self, title, name, modifier, keys = '', custom = ''):
        self.all.append(
            Simlayer(title, name, modifier, keys, custom)
        )

    def primary(self, title, name, modifier, keys = ''):
        self.all.append(
            Simlayer(title, name, modifier, keys).setAsPrimary()
        )

    def available(self, modifier):
        self.all.append(
            Simlayer('', '', modifier, '').setAsAvailable()
        )

    def definitions(self):
        return '\n'.join(map(Simlayer.definition, filter(Simlayer.isNotPrimary, self.all)))

    def rulesets(self):
        return '\n'.join(filter(bool, map(Simlayer.ruleset, self.all)))
