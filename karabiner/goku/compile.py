from functions import *
from Simlayers import *

simlayers = Simlayers()

simlayers.primary('Hyper Mode (Key: Caps Lock)', 'HyperMode', 'caps_lock', 'all-right')

simlayers.new('Tab Mode (Key: tab)', 'TabMode', 'tab', 'all-right')
simlayers.available('q')
simlayers.available('w')
simlayers.available('e')
simlayers.new('Pane Mode (Key: r)', 'PaneMode', 'r', 'all-right')
simlayers.new('Test Mode (Key: T)', 'TestMode', 't', 'l,k,m')

simlayers.new('Yank Mode (Key: Y)', 'YankMode', 'y', 'all-left')
simlayers.new('Select Until Mode (Key: u)', 'SelectUntilMode', 'u', 'all-left')
simlayers.new('Select Inside Mode (Key: i)', 'SelectInsideMode', 'i', 'all-left')
simlayers.new('Open Mode (Key: O)', 'OpenMode', 'o', 'all')
simlayers.new('Paste Mode (Key: P)', 'PasteMode', 'p', 'all-left')
simlayers.new('Destroy Mode (Key: [)', 'DestroyMode', 'open_bracket', 'all-left')
simlayers.available(']')

simlayers.new('Case Mode (Key: A)', 'CaseMode', 'a', 'all-right')
simlayers.new('Snippet Mode (Key: S)', 'SnippetMode', 's', 'all')
simlayers.new('Vi Mode (Key: D)', 'ViMode', 'd', """
                [:##y :!Cup_arrow] ; Top of page
                [:##u :page_up]
                [:##i [:hs "handle-karabiner?layer=ViMode&key=i"]]
                [:##o [:hs "handle-karabiner?layer=ViMode&key=o"]]
                [:##h :left_arrow]
                [:##j :down_arrow]
                [:##k :up_arrow]
                [:##l :right_arrow]
                [:##semicolon [:hs "handle-karabiner?layer=ViMode&key=semicolon"]]
                [:##quote [:hs "handle-karabiner?layer=ViMode&key=quote"]]
                [:##n :!Cdown_arrow] ; Bottom of page
                [:##m :page_down]
                [:##period :!Oright_arrow] ; Previous word
                [:##comma :!Oleft_arrow] ; Next word
""")
simlayers.new('General Mode (Key: F)', 'GeneralMode', 'f', 'all')
simlayers.new('Google Mode (Key: G)', 'GoogleMode', 'g', 'all-right')

simlayers.new('Command Mode (Key: ;)', 'CommandMode', 'semicolon', 'all-left')
simlayers.new("Extended Command Mode (Key: ')", 'ExtendedCommandMode', 'quote', 'all-left')
simlayers.new('Jump to Mode (Key: return)', 'JumpToMode', 'return_or_enter', 'all-left')

simlayers.new('Dialog Case Mode (Key: Z)', 'CaseDialog', 'z', 'all-right')
simlayers.available('x')
simlayers.new('Code Mode (Key: C)', 'CodeMode', 'c', 'all-right')
simlayers.new('Vi Visual Mode (Key: V)', 'ViVisualMode', 'v', """
                [:##y :!SCup_arrow] ; Top of page
                [:##i :!SCleft_arrow]
                [:##o :!SCright_arrow]
                [:##open_bracket :!SOup_arrow]
                [:##close_bracket :!SOdown_arrow]
                [:##h :!Sleft_arrow]
                [:##j :!Sdown_arrow]
                [:##k :!Sup_arrow]
                [:##l :!Sright_arrow]
                [:##n :!SCdown_arrow] ; Bottom of page
                [:##period :!SOright_arrow] ; Previous word
                [:##comma :!SOleft_arrow] ; Next word
""")
simlayers.available('b')

simlayers.new('Change Mode (Key: n)', 'ChangeMode', 'n', 'all-left')
simlayers.new('Media Mode (Key: M)', 'MediaMode', 'm', 'all')
simlayers.new('Launch Mode (Key: ,)', 'LaunchMode', 'comma', 'all-left')
simlayers.new('App Mode (Key: .)', 'AppMode', 'period', 'all')
simlayers.new('Search Mode (Key: /)', 'SearchMode', 'slash', 'all-left')

simlayers.new('Window Mode (Key: Spacebar)', 'WindowManager', 'spacebar', 'all')

compileTemplate(simlayers)
