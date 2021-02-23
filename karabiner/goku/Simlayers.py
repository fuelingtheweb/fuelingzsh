from Simlayer import *

class Simlayers:
    all = []

    def new(self, title, name, modifier, keys = '', static = True, primary = False):
        self.all.append(Simlayer(title, name, modifier, keys, static, primary))

    def primary(self, title, name, modifier, keys = '', static = False, primary = True):
        self.all.append(Simlayer(title, name, modifier, keys, static, primary))

    def usesHandler(self, title, name, modifier, keys = '', static = False, primary = False):
        self.all.append(Simlayer(title, name, modifier, keys, static, primary))

    def available(self, modifier):
        self.all.append(Simlayer.available(modifier))

    def definitions(self):
        return '\n'.join(map(Simlayer.definition, filter(Simlayer.isNotPrimary, self.all)))

    def rulesets(self):
        return '\n'.join(filter(bool, map(Simlayer.ruleset, self.all)))
