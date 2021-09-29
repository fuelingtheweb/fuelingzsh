from functions import compileTemplate
from Simlayers import *

simlayers = Simlayers()

simlayers.primary('Modifier: Caps Lock', 'hyper', 'caps_lock', 'all-right')

simlayers.new('Modifier: tab', 'tabModifier', 'tab', 'all-right')
simlayers.new('Modifier: q', 'qModifier', 'q', 'all-right')
simlayers.available('w')
simlayers.available('e')
simlayers.new('Modifier: r', 'rModifier', 'r', 'all-right')
simlayers.new('Modifier: T', 'tModifier', 't', 'all-right')

simlayers.new('Modifier: Y', 'yModifier', 'y', 'all-left')
simlayers.new('Modifier: u', 'uModifier', 'u', 'all')
simlayers.new('Modifier: i', 'iModifier', 'i', 'all-left')
simlayers.new('Modifier: O', 'oModifier', 'o', 'all')
simlayers.new('Modifier: P', 'pModifier', 'p', 'all-left')
simlayers.new('Modifier: [', 'openBracketModifier', 'open_bracket', 'all-left')
simlayers.new('Modifier: ]', 'closeBracketModifier', 'close_bracket', 'all-left')

simlayers.new('Modifier: A', 'aModifier', 'a', 'all-right')
simlayers.new('Modifier: S', 'sModifier', 's', 'all')
simlayers.new('Modifier: D', 'dModifier', 'd', 'all-right')
simlayers.new('Modifier: F', 'fModifier', 'f', 'all')
simlayers.new('Modifier: G', 'gModifier', 'g', 'all-right')

simlayers.new('Modifier: ;', 'semicolonModifier', 'semicolon', 'all-left')
simlayers.new("Modifier: ')", 'quoteModifier', 'quote', 'all-left')
simlayers.new('Modifier: return', 'returnModifier', 'return_or_enter', 'all-left')

simlayers.new('Modifier: Z', 'zModifier', 'z', 'all-right')
simlayers.new('Modifier: X', 'xModifier', 'x', 'all-right')
simlayers.new('Modifier: C', 'cModifier', 'c', 'all-right')
simlayers.new('Modifier: V', 'vModifier', 'v', 'all-right')
simlayers.available('b')

simlayers.new('Modifier: n', 'nModifier', 'n', 'all-left')
simlayers.new('Modifier: M', 'mModifier', 'm', 'all-left')
simlayers.new('Modifier: ,', 'commaModifier', 'comma', 'all-left')
simlayers.new('Modifier: .', 'periodModifier', 'period', 'all-left')
simlayers.new('Modifier: /', 'slashModifier', 'slash', 'all-left')

simlayers.new('Modifier: Spacebar', 'spacebarModifier', 'spacebar', 'all')

compileTemplate(simlayers, """
        {
            :des "Misc"
            :rules [
                [:right_option [[:hs "misc-optionPressedTwice"] ["pending" 0]] ["pending" 1]]
                [:right_option
                    ["pending" 1]
                    ["pending" 0]
                    {:delayed {:invoked [[:hs "misc-optionPressedOnce"] ["pending" 0]] :canceled ["pending" 0]} :params {:delay 150}}
                ]

                [:fn {:pkey :button1}] ; Mouse click. Hold for dragging
                [:!TCf :escape] ; Escape
            ]
        }
        {
            :des "Simultaneous d + f"
            :rules [[
                {
                    :sim [:d :f]
                    :simo {
                        :interrupt true
                        :dorder :insensitive
                        :uorder :insensitive
                        :afterup {:set ["SimDF" 0]}
                    }
                }
                {:set ["SimDF" 1]}
            ]]
        }
        {
            :des "SimDF (Keys: D+F)"
            :rules [:SimDF
                [:u [:t :e :s :t]]
            ]
        }
""")
