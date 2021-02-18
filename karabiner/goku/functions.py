from string import Template

def compileTemplate(simlayers):
    print(
        Template(fileContents('template')).substitute({
            'simlayers': simlayers.definitions(),
            'rulesets': simlayers.rulesets(),
            'main': fileContents('main').strip(),
            'textManipulation': fileContents('text-manipulation').strip(),
            'vim': fileContents('vim').strip(),
        })
    )

def fileContents(fileName):
    with open("/Users/nathan/.fuelingzsh/karabiner/goku/%s.edn" % (fileName), 'r') as f:
        return f.read()
