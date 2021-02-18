from string import Template

def compileTemplate(hyperMode, simlayers):
    print(
        Template(fileContents('template')).substitute({
            'hyperMode': hyperMode,
            'simlayers': simlayers.definitions(),
            'rulesets': simlayers.rulesets(),
        })
    )

def fileContents(fileName):
    with open("/Users/nathan/.fuelingzsh/karabiner/goku/%s.edn" % (fileName), 'r') as f:
        return f.read()
