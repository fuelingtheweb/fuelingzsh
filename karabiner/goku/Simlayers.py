from Simlayer import *

class Simlayers:
    all = []

    def new(self, title, name, modifier, keys = '', static = True):
        self.all.append(Simlayer(title, name, modifier, keys, static))

    def usesHandler(self, title, name, modifier, keys = '', static = False):
        self.all.append(Simlayer(title, name, modifier, keys, static))

    def available(self, modifier):
        self.all.append(Simlayer.available(modifier))

    def definitions(self):
        return '\n'.join(map(Simlayer.definition, self.all))

    def rulesets(self):
        return '\n'.join(filter(bool, map(Simlayer.ruleset, self.all)))
