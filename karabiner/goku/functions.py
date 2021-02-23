from string import Template

def compileTemplate(simlayers):
    print(
        Template(fileContents('template')).substitute({
            'simlayers': simlayers.definitions(),
            'rulesets': simlayers.rulesets(),
        })
    )

def fileContents(fileName):
    with open("/Users/nathan/.fuelingzsh/karabiner/goku/%s.edn" % (fileName), 'r') as f:
        return f.read()
