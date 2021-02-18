import sys
from functions import *

compileTemplate(
"""
    :layers {
        :hyper-mode {:key :caps_lock :alone {:key :escape}}
    }
    :simlayers {
"""
""
+ simlayer('', 'tab-mode', 'tab')
+ availableSimlayer('q')
+ availableSimlayer('w')
+ availableSimlayer('e')
+ simlayer('', 'pane-mode', 'r')
+ simlayer('Test Mode (Key: T)', 'test-mode', 't')
+ "\n"
+ simlayer('', 'yank-mode', 'y')
+ simlayer('', 'select-until-mode', 'u')
+ simlayer('', 'select-inside-mode', 'i')
+ simlayer('', 'open-mode', 'o')
+ simlayer('', 'paste-mode', 'p')
+ simlayer('', 'destroy-mode', 'open_bracket')
+ availableSimlayer(']')
+ "\n"
+ simlayer('', 'case-mode', 'a')
+ simlayer('', 'snippet-mode', 's')
+ simlayer('', 'vi-mode', 'd')
+ simlayer('', 'general-mode', 'f')
+ simlayer('', 'google-mode', 'g')
+ "\n"
+ simlayer('', 'command-mode', 'semicolon')
+ simlayer('', 'extended-command-mode', 'quote')
+ simlayer('', 'jump-to-mode', 'return_or_enter')
+ "\n"
+ simlayer('', 'dialog-case-mode', 'z')
+ availableSimlayer('x')
+ simlayer('', 'code-mode', 'c')
+ simlayer('', 'vi-visual-mode', 'v')
+ availableSimlayer('b')
+ "\n"
+ simlayer('', 'change-mode', 'n')
+ simlayer('', 'media-mode', 'm')
+ simlayer('', 'launch-mode', 'comma')
+ simlayer('', 'app-mode', 'period')
+ simlayer('', 'search-mode', 'slash')
+ "\n"
+ simlayer('', 'window-mode', 'spacebar')
+ """    }""",
ruleset('test-mode', 'l,k,m')
)
