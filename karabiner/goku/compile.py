from functions import *
from Simlayers import *

simlayers = Simlayers()

simlayers.new('Tab Mode (Key: tab)', 'tab-mode', 'tab', """
                [:i [:!C1]] ; Go to first tab
                [:o [:!C9]] ; Go to last tab
                [:p [:t :p]] ; Chrome: Pin Tab
                [:close_bracket [:hs "tab-moveToNewWindow"]]

                [:h [:hs "tab-moveLeft"]]
                [:l [:hs "tab-moveRight"]]

                [:n [:hs "tab-new"]]
                [:comma [:hs "tab-closeAllToLeft"]]
                [:period [:hs "tab-closeAllToRight"]]
                [:slash [:hs "tab-closeAllOthers"]]
""")
simlayers.available('q')
simlayers.available('w')
simlayers.available('e')
simlayers.new('', 'pane-mode', 'r')
simlayers.usesHandler('Test Mode (Key: T)', 'TestMode', 't', 'l,k,m')

simlayers.new('', 'yank-mode', 'y')
simlayers.new('', 'select-until-mode', 'u')
simlayers.new('', 'select-inside-mode', 'i')
simlayers.new('', 'open-mode', 'o')
simlayers.new('', 'paste-mode', 'p')
simlayers.new('', 'destroy-mode', 'open_bracket')
simlayers.available(']')

simlayers.new('', 'case-mode', 'a')
simlayers.new('', 'snippet-mode', 's')
simlayers.new('', 'vi-mode', 'd')
simlayers.new('', 'general-mode', 'f')
simlayers.new('', 'google-mode', 'g')

simlayers.new('', 'command-mode', 'semicolon')
simlayers.new('', 'extended-command-mode', 'quote')
simlayers.new('', 'jump-to-mode', 'return_or_enter')

simlayers.new('', 'dialog-case-mode', 'z')
simlayers.available('x')
simlayers.new('', 'code-mode', 'c')
simlayers.new('', 'vi-visual-mode', 'v')
simlayers.available('b')

simlayers.new('', 'change-mode', 'n')
simlayers.new('', 'media-mode', 'm')
simlayers.new('', 'launch-mode', 'comma')
simlayers.new('', 'app-mode', 'period')
simlayers.new('', 'search-mode', 'slash')

simlayers.new('', 'window-mode', 'spacebar')

compileTemplate(simlayers)
