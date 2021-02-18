from string import Template

simlayers = dict()

def compileTemplate(setup, rulesets):
    print(
        Template(fileContents('template')).substitute({
            'setup': setup,
            'rulesets': rulesets,
            'main': fileContents('main').strip(),
            'textManipulation': fileContents('text-manipulation').strip(),
            'vim': fileContents('vim').strip(),
        })
    )

def simlayer(title, name, key):
    simlayers[name] = {'title': title, 'name': name, 'key': key}

    return "%s:%s {:key :%s}\n" % (indent(2), name, key)

def availableSimlayer(key):
    return "%s; %s\n" % (indent(2), key)

def ruleset(name, keys):
    simlayer = simlayers[name]
    title = simlayer['title']
    rules = ''

    for key in keys.split(','):
        rules += "[:%s [:hs \"handle-karabiner?layer=%s&key=%s\"]]\n%s" % (key, name, key, indent(4))

    return """%s{
            :des \"%s\"
            :rules [:%s
                %s
            ]
        }""" % (indent(2), title, name, rules.rstrip())

def fileContents(fileName):
    with open("/Users/nathan/.fuelingzsh/karabiner/goku/%s.edn" % (fileName), 'r') as f:
        return f.read()

def indent(count):
    return '    ' * count
