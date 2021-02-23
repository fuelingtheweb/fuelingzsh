from functions import *
from Simlayers import *

simlayers = Simlayers()

simlayers.primary('Hyper Mode (Key: Caps Lock)', 'HyperMode', 'caps_lock', 'all-right')

simlayers.usesHandler('Tab Mode (Key: tab)', 'TabMode', 'tab', 'all-right')
simlayers.available('q')
simlayers.available('w')
simlayers.available('e')
simlayers.usesHandler('Pane Mode (Key: r)', 'PaneMode', 'r', 'all-right')
simlayers.usesHandler('Test Mode (Key: T)', 'TestMode', 't', 'l,k,m')

simlayers.new('Yank Mode (Key: Y)', 'yank-mode', 'y', """
                [:e [:hs "yank-toEndOfWord"]]
                [:r [:hs "yank-relativeFilePath"]]

                [:w [:hs "yank-word"]]
                [:t [:escape :y :i :t]]; t -> tag
                [:s [:escape :y :i :quote]]; s -> single quotes
                [:d [:escape :y :i :!Squote]]; d -> double quotes
                [:z [:escape :y :i :z]]; z -> back ticks
                [:f [:escape :y :i :!S9]]; f -> parenthesis
                [:c [:escape :y :i :!Sopen_bracket]]; c -> braces
                [:b [:escape :y :i :open_bracket]]; b -> brackets

                [:a [:hs "yank-toEndOfLine"]]
                [:i [:hs "yank-toBeginningOfLine"]]
                [:v [:hs "yank-line"]]
                [:x [:hs "yank-character"]]

                [:caps_lock [:hs "yank-all"]]
                [:q [:hs "yank-viewPath"]]
""")
simlayers.usesHandler('Select Until Mode (Key: u)', 'SelectUntilMode', 'u', 'all-left')
simlayers.new('Select Inside Mode (Key: i)', 'select-inside-mode', 'i', """
                [:w [:hs "select-inside-word"]]
                [:t [:escape :v :i :t]]; t -> tag
                [:s [:escape :v :i :quote]]; s -> single quotes
                [:d [:escape :v :i :!Squote]]; d -> double quotes
                [:z [:escape :v :i :z]]; z -> back ticks
                [:f [:escape :v :i :!S9]]; f -> parenthesis
                [:c [:escape :v :i :!Sopen_bracket]]; c -> braces
                [:b [:escape :v :i :open_bracket]]; b -> brackets

                [:v [:hs "select-inside-line"]]
                [:x [:hs "select-inside-character"]]
""")
simlayers.new('Open Mode (Key: O)', 'open-mode', 'o', """
                ; tab
                [:q [:hs "custom-open?key=Q"]]
                [:w [:hs "custom-open?key=W"]]
                [:e [:hs "custom-open?key=E"]]
                [:r [:hs "open-inAtom"]]
                [:t [:hs "custom-open?key=T"]]

                [:y [:hs "custom-open?key=Y"]]

                ; caps
                [:a [:sublime "~/.fuelingzsh/aliases"]]
                [:s [:sublime "~/.fuelingzsh/custom/espanso/default.yml"]]
                [:d "open ~/Downloads"]
                [:f [:hs "custom-open?key=F"]]
                [:g [:hs "open-inChrome"]]

                [:h [:sublime "~/.hammerspoon"]]
                [:k [:hs "open-karabiner"]]

                [:z [:sublime "~/.fuelingzsh"]]
                [:x [:hs "open-inTinkerwell"]]
                [:c [:hs "open-inSublimeMerge"]]
                [:v [:hs "open-inTablePlus"]]
                [:b [:hs "open-inFinder"]]

                [:m [:hs "custom-open?key=M"]]
""")
simlayers.new('Paste Mode (Key: P)', 'paste-mode', 'p', """
                [:e [:hs "paste-toEndOfWord"]]

                [:w [:hs "paste-word"]]
                [:t [:escape :v :i :t :p]]; t -> tag
                [:s [:escape :v :i :quote :p]]; s -> single quotes
                [:d [:escape :v :i :!Squote :p]]; d -> double quotes
                [:z [:escape :v :i :z :p]]; z -> back ticks
                [:f [:escape :v :i :!S9 :p]]; f -> parenthesis
                [:c [:escape :v :i :!Sopen_bracket :p]]; c -> braces
                [:b [:escape :v :i :open_bracket :p]]; b -> brackets

                [:a [:hs "paste-toEndOfLine"]]
                [:i [:hs "paste-toBeginningOfLine"]]
                [:v [:hs "paste-line"]]
                [:x [:hs "paste-character"]]

                [:caps_lock [:alfred "paste:strip" "com.fuelingtheweb.commands"]]
""")
simlayers.new('Destroy Mode (Key: [)', 'destroy-mode', 'open_bracket', """
                [:e [:hs "destroy-toEndOfWord"]]

                [:w [:hs "destroy-word"]]
                [:t [:escape :d :i :t]]; t -> tag
                [:s [:escape :d :i :quote]]; s -> single quotes
                [:d [:escape :d :i :!Squote]]; d -> double quotes
                [:z [:escape :d :i :z]]; z -> back ticks
                [:f [:escape :d :i :!S9]]; f -> parenthesis
                [:c [:escape :d :i :!Sopen_bracket]]; c -> braces
                [:b [:escape :d :i :open_bracket]]; b -> brackets

                [:a [:hs "destroy-toEndOfLine"]]
                [:i [:hs "destroy-toBeginningOfLine"]]
                [:v [:hs "destroy-line"]]
                [:x [:hs "destroy-character"]]
                [:spacebar :delete_or_backspace]
""")
simlayers.available(']')

simlayers.usesHandler('Case Mode (Key: A)', 'CaseMode', 'a', 'all-right')
simlayers.new('Snippet Mode (Key: S)', 'snippet-mode', 's', """
                [:e [:hs "snippet?name=elseif"]]
                ; r
                [:t [:hs "snippet-this"]]
                [:d [:hs "snippet?name=dd"]]
                ; f, g, v
                ; y, u
                [:i [:hs "snippet?name=if"]]
                ; o
                [:p [:hs "snippet?name=property"]]
                [:open_bracket [:hs "snippet?name=echo"]]
                ; ]
                ; h, j, k
                [:l [:hs "snippet?name=log"]]
                ; ;, ', return
                [:n [:hs "snippet?name=af"]]

                ; Snippet: Method
                [:m [[:hs "snippet-mode-method"] ["pending" 0]] ["pending" 1]]
                [:m
                    ["pending" 1]
                    ["pending" 0]
                    {:delayed {:invoked [[:hs "snippet-method"] ["pending" 0]] :canceled ["pending" 0]} :params {:delay 150}}
                ]

                ; ,, ., /
""")
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
simlayers.usesHandler('General Mode (Key: F)', 'GeneralMode', 'f', 'all')
simlayers.new('Google Mode (Key: G)', 'google-mode', 'g', """
                [:y [:hs "custom-open?key=Y"]]
                ; u
                [:i [:chrome "https://inbox.google.com"]]
                [:o [:hs "google-toggleIncognito"]]
                [:p :!SCm] ; Chrome: Show profiles list
                [:open_bracket :!TOCg] ; Chrome: Group Tab
                ; ]

                [:h [:alfred "history" "com.thomasupton.chrome-history"]]
                ; j
                ; k
                [:l :!!l] ; Lastpass
                ; ;
                [:semicolon :!SCm] ; Chrome: Tab Manager
                [:quote [:hs "google-openAndReload"]]
                [:return_or_enter :!Ow] ; Chrome: Dismiss downloads bar

                [:n :!Cd] ; Chrome: Save Bookmark
                [:m [:alfred "bookmarks" "com.chrome.bookmarks"]] ; Google bookmarks
                [:comma :!OCi] ; Chrome: Toggle Dev Tools
                [:period :!SCd] ; Chrome: Toggle Dev Tools docking
                ; /
""")

simlayers.new('Command Mode (Key: ;)', 'command-mode', 'semicolon', """
                [:tab :!Stab] ; Shift Tab
                [:q :!Cq] ; Quit

                ; Close window or close all windows
                [:w [[:hs "command-closeAllWindows"] ["pending" 0]] ["pending" 1]]
                [:w
                    ["pending" 1]
                    ["pending" 0]
                    {:delayed {:invoked [[:hs "command-closeWindow"] ["pending" 0]] :canceled ["pending" 0]} :params {:delay 150}}
                ]

                ; Edit With
                [:e [[:hs "command-edit?done=1"] ["pending" 0]] ["pending" 1]]
                [:e
                    ["pending" 1]
                    ["pending" 0]
                    {:delayed {:invoked [[:hs "command-edit"] ["pending" 0]] :canceled ["pending" 0]} :params {:delay 150}}
                ]

                ; Reload or Chrome hard refresh
                [:r [[:hs "command-reloadSecondary"] ["pending" 0]] ["pending" 1]]
                [:r
                    ["pending" 1]
                    ["pending" 0]
                    {:delayed {:invoked [[:hs "command-reload"] ["pending" 0]] :canceled ["pending" 0]} :params {:delay 150}}
                ]

                ; t

                [:caps_lock [:alfred "commands" "com.fuelingtheweb.commands"]]
                [:a :!Ca] ; Select All

                ; Save or Save and reload Chrome
                [:s [[:hs "command-saveAndReload"] ["pending" 0]] ["pending" 1]]
                [:s
                    ["pending" 1]
                    ["pending" 0]
                    {:delayed {:invoked [[:hs "command-save"] ["pending" 0]] :canceled ["pending" 0]} :params {:delay 150}}
                ]

                [:d [:hs "command-done"]]
                [:f [:hs "command-find"]]
                [:g :!SCh] ; Atom: Toggle Git Palette

                [:z [:alfredsearch "sleep"]] ; Alfred: Sleep
                [:x [:hs "command-cancelOrDelete"]] ; Control C
                ; c
                [:v [:escape :y :y :p]] ; Duplicate line
                ; b
""")
simlayers.new("Extended Command Mode (Key: ')", 'extended-command-mode', 'quote', """
                ; q
                [:w [:hs "command-surroundText"]]
                ; e
                [:r :!SCz] ; Redo
                ; t

                [:caps_lock [:hs "command-dismissNotifications"]] ; Dismiss notifications
                [:a :!OCbackslash] ; Alfred: Action File
                [:s :!SC4] ; Screenshot to filesystem
                [:d [:hs "command-duplicate"]]
                [:f [:!SCbackslash]] ; Atom: Reveal active file in tree view
                [:g :!OCd] ; Toggle dock visibility

                [:z :!Cz] ; Undo
                ; x
                [:c :!STC4] ; Screenshot to clipboard
                [:v :!TOCs] ; Vimac: Enable Scroll
                [:b :!STCb] ; Bartender: Show

                [:n :!SCn] ; New window / folder
""")
simlayers.new('Jump to Mode (Key: return)', 'jump-to-mode', 'return_or_enter', """
                [:s [:f :quote]]; s -> single quotes
                [:d [:f :!Squote]]; d -> double quotes
                [:z [:f :!Ograve_accent_and_tilde]]; z -> back ticks

                ; opening / closing parenthesis
                [:f [:!S0 ["bracket-pending" 0]] ["bracket-pending" 1]]
                [:f
                    [:f ["bracket-pending" 1]]
                    ["bracket-pending" 0]
                    {:delayed {:invoked [:!S9 ["bracket-pending" 0]] :canceled ["bracket-pending" 0]} :params {:delay 150}}
                ]

                ; opening / closing braces
                [:c [:!Sclose_bracket ["bracket-pending" 0]] ["bracket-pending" 1]]
                [:c
                    [:f ["bracket-pending" 1]]
                    ["bracket-pending" 0]
                    {:delayed {:invoked [:!Sopen_bracket ["bracket-pending" 0]] :canceled ["bracket-pending" 0]} :params {:delay 150}}
                ]

                ; opening / closing brackets
                [:b [:close_bracket ["bracket-pending" 0]] ["bracket-pending" 1]]
                [:b
                    [:f ["bracket-pending" 1]]
                    ["bracket-pending" 0]
                    {:delayed {:invoked [:open_bracket ["bracket-pending" 0]] :canceled ["bracket-pending" 0]} :params {:delay 150}}
                ]

                [:t [:!Sopen_bracket]] ; Previous block
""")


simlayers.usesHandler('Dialog Case Mode (Key: Z)', 'CaseDialog', 'z', 'all-right')
simlayers.available('x')
simlayers.usesHandler('Code Mode (Key: C)', 'CodeMode', 'c', 'all-right')
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

simlayers.new('Change Mode (Key: n)', 'change-mode', 'n', """
                [:e [:hs "change-toEndOfWord"]]

                [:w [:hs "change-word"]]
                [:t [:escape :c :i :t]]; t -> tag
                [:s [:escape :c :i :quote]]; s -> single quotes
                [:d [:escape :c :i :!Squote]]; d -> double quotes
                [:z [:escape :c :i :z]]; z -> back ticks
                [:f [:escape :c :i :!S9]]; f -> parenthesis
                [:c [:escape :c :i :!Sopen_bracket]]; c -> braces
                [:b [:escape :c :i :open_bracket]]; b -> brackets

                [:a [:hs "change-toEndOfLine"]]
                [:i [:hs "change-toBeginningOfLine"]]
                [:v [:hs "change-line"]]
                [:x [:hs "change-character"]]

                ; [:caps_lock :!SCv] ; Global Vim Mode
                [:caps_lock [:hs "text-disableVim"]]
""")
simlayers.new('Media Mode (Key: M)', 'media-mode', 'm', """
                [:z [:alfredsearch "Sound"]]
                [:r [:hs "media-updateAudioDevice"]]
                [:s :!!z] ; Alfred: Spotify
                [:d :!SCd] ; Deafen in Discord
                [:a :!Tleft_arrow] ; Funimation: Start of video / previous video
                [:g :!Tright_arrow] ; Funimation: Next video
                [:v [:hs "media-focus"]]
                [:f [:hs "media-fullscreen"]]
                [:comma [:hs "media-back"]]
                [:period [:hs "media-forward"]]
""")
simlayers.new('Launch Mode (Key: ,)', 'launch-mode', 'comma', """
                ; tab
                [:q [:launch "Kaleidoscope.app"]]
                [:w [:launch "Transmit.app"]]
                [:e [:hs "launch-app?id=sublime"]]
                [:r [:hs "launch-app?id=atom"]]
                [:t [:hs "launch-app?id=iterm"]]

                [:caps_lock [:launch "Dash.app"]]

                ; Fanstastical or Alfred Preferences
                [:a [[:hs "launch-app?id=alfred-preferences"] ["pending" 0]] ["pending" 1]]
                [:a
                    ["pending" 1]
                    ["pending" 0]
                    {:delayed {:invoked [:!OCc ["pending" 0]] :canceled ["pending" 0]} :params {:delay 150}}
                ]

                [:s [:hs "launch-app?id=spotify"]]
                [:d [:launch "Discord.app"]]
                [:f [:launch "Notion.app"]]
                [:g [:hs "launch-app?id=chrome"]]

                ; Zoom or Screen
                [:z [[:launch "Screen.app"] ["pending" 0]] ["pending" 1]]
                [:z
                    ["pending" 1]
                    ["pending" 0]
                    {:delayed {:invoked [[:launch "zoom.us.app"] ["pending" 0]] :canceled ["pending" 0]} :params {:delay 150}}
                ]

                [:x [:hs "launch-beyond-code-app"]]
                [:c [:launch "Sublime Merge.app"]]
                [:v [:launch "TablePlus.app"]]
                [:b [:hs "launch-app?id=finder"]]

                [:spacebar [:hs "window-bringAllToFront"]]
""")
simlayers.usesHandler('App Mode (Key: .)', 'AppMode', 'period', 'all')
simlayers.new('Search Mode (Key: /)', 'search-mode', 'slash', """
                [:caps_lock [:hs "search-default"]]
                [:w [:hs "window-searchInCurrentApp"]]
                [:t [:hs "search-tabs"]]

                [:a [:hs "window-searchAll"]]
                [:s :!Cr] ; Search for symbol
                [:f [:alfredsearch "open "]] ; Search files
                [:g [:alfred "google" "com.akikoz.alfred.websearchsuggest"]]

                [:z [:alfred "amazon" "com.akikoz.alfred.websearchsuggest"]]
                [:c [:slash :!Scomma :!Scomma :!Scomma :!Scomma :!Scomma :return_or_enter]] ; Search for conflicts
""")

simlayers.usesHandler('Window Mode (Key: Spacebar)', 'WindowManager', 'spacebar', 'all')

compileTemplate(simlayers)
