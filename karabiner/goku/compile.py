from functions import *
from Simlayers import *

simlayers = Simlayers()

hyperMode = """
        {
            :des "Hyper Mode (Key: Caps Lock)"
            :rules [:hyper-mode
                [:y [:hs "hyper-copy"]]
                [:u [:hs "hyper-copyTextArea"]]
                ; i
                [:o [:hs "hyper-open"]]
                [:p :!Cv] ; Paste
                [:open_bracket [:hs "hyper-openAnything"]]
                [:close_bracket [:hs "hyper-commandPalette"]] ; Command palette

                [:h [:hs "hyper-previousPage"]] ; Navigate to previous page
                [:j [:hs "hyper-previousTab"]]
                [:k [:hs "hyper-nextTab"]]
                [:l [:hs "hyper-nextPage"]] ; Navigate to next page
                ; ;
                ; '
                [:return_or_enter :caps_lock]

                [:n :!Oz] ; Alfred
                [:m :!Oc] ; Alfred Clipboard
                [:comma [:hs "hyper-jumpTo"]]
                ; .
                ; /

                ; spacebar
            ]
        }
"""

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
simlayers.new('Pane Mode (Key: r)', 'pane-mode', 'r', """
                [:open_bracket [:hs "pane-destroy"]]
                [:j [:hs "pane-focusPrevious"]]
                [:k [:hs "pane-focusNext"]]
                [:l [:hs "pane-splitRight"]]

                [:m [:hs "pane-splitBottom"]]
                [:semicolon [:hs "pane-toggleZoom"]]
""")
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
simlayers.new('Select Until Mode (Key: u)', 'select-until-mode', 'u', """
                [:e [:hs "select-until-endOfWord"]]

                [:w [:hs "select-until-next-word"]]
                [:s [:hs "select-until-single-quote"]]
                [:d [:v :t :!Squote]]; d -> double quotes
                [:z [:v :t :!Ograve_accent_and_tilde]]; z -> back ticks

                ; opening / closing parenthesis
                [:f [:!S0 ["bracket-pending" 0]] ["bracket-pending" 1]]
                [:f
                    [:v :t ["bracket-pending" 1]]
                    ["bracket-pending" 0]
                    {:delayed {:invoked [:!S9 ["bracket-pending" 0]] :canceled ["bracket-pending" 0]} :params {:delay 150}}
                ]

                ; opening / closing braces
                [:c [:!Sclose_bracket ["bracket-pending" 0]] ["bracket-pending" 1]]
                [:c
                    [:v :t ["bracket-pending" 1]]
                    ["bracket-pending" 0]
                    {:delayed {:invoked [:!Sopen_bracket ["bracket-pending" 0]] :canceled ["bracket-pending" 0]} :params {:delay 150}}
                ]

                ; opening / closing brackets
                [:b [:close_bracket ["bracket-pending" 0]] ["bracket-pending" 1]]
                [:b
                    [:v :t ["bracket-pending" 1]]
                    ["bracket-pending" 0]
                    {:delayed {:invoked [:open_bracket ["bracket-pending" 0]] :canceled ["bracket-pending" 0]} :params {:delay 150}}
                ]

                [:a [:hs "select-until-endOfLine"]]
                [:i [:hs "select-until-beginningOfLine"]]
                [:t [:hs "select-until-previousBlock"]]
""")
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

simlayers.new('Case Mode (Key: A)', 'case-mode', 'a', """
                [:y [:hs "case-change?to=upperFirst&key=y"]]
                [:u [:hs "case-change?to=upper&key=u"]]
                [:i [:hs "case-change?to=constant&key=i"]]
                [:o [:hs "case-change?to=kebab&key=o"]]
                [:p [:hs "case-change?to=pascal&key=p"]]

                [:h [:hs "case-change?to=title&key=h"]]
                [:j [:hs "case-change?to=sentence&key=j"]]
                [:k [:hs "case-change?to=snake&key=k"]]
                [:l [:hs "case-change?to=lower&key=l"]]

                [:m [:hs "case-change?to=camel&key=m"]]
                [:period [:hs "case-change?to=dot&key=."]]
                [:slash [:hs "case-change?to=path&key=/"]]
""")
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
simlayers.new('Vi Mode (Key: D)', 'vi-mode', 'd', """
                [:##j :down_arrow]
                [:##k :up_arrow]
                [:##h :left_arrow]
                [:##l :right_arrow]
                [:##b :!Oleft_arrow]
                [:##n :!Oleft_arrow]
                [:##w :!Oright_arrow]
                [:##0 :!Cleft_arrow]
                [:##4 :!Cright_arrow]
                [:##a [:hs "handle-karabiner?layer=ViMode&key=a"]]
                [:##i :!Cleft_arrow]
                [:##m :!Cdown_arrow]
                [:##u :!Cup_arrow]
                [:##comma :page_up]
                [:##period :page_down]
                [:##open_bracket :!Si]
                [:##close_bracket :!Sa]
""")
simlayers.new('General Mode (Key: F)', 'general-mode', 'f', """
                [:y :!S7] ; &
                [:u :!Shyphen] ; _
                [:i :hyphen] ; -
                [:o :keypad_plus] ; +
                [:p :!Sbackslash] ; |
                [:open_bracket :!S9] ; (
                [:close_bracket :!S0] ; )

                [:h :!Sgrave_accent_and_tilde] ; ~
                ; j
                ; k
                ; l
                ; ;
                [:quote :equal_sign] ; =
                ; return

                [:n [:!Ograve_accent_and_tilde :spacebar]] ; `
                [:m :!S8] ; Multiply: *
                [:comma :!S5] ; %
                [:period [:hyphen :!Speriod]] ; ->
                ; /

                [:q :!S3] ; #
                ; w
                [:e :!S1] ; !

                [:a :!S2] ; @
                ; s
                [:d :!S4] ; -> $
""")
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
                [:r [:!SCr ["pending" 0]] ["pending" 1]]
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

simlayers.new('Dialog Case Mode (Key: Z)', 'dialog-case-mode', 'z', """
                [:y [:hs "case-dialog?to=upperFirst"]]
                [:u [:hs "case-dialog?to=upper"]]
                [:i [:hs "case-dialog?to=constant"]]
                [:o [:hs "case-dialog?to=kebab"]]
                [:p [:hs "case-dialog?to=pascal"]]

                [:h [:hs "case-dialog?to=title"]]
                [:j [:hs "case-dialog?to=sentence"]]
                [:k [:hs "case-dialog?to=snake"]]
                [:l [:hs "case-dialog?to=lower"]]

                [:m [:hs "case-dialog?to=camel"]]
                [:period [:hs "case-dialog?to=dot"]]
                [:slash [:hs "case-dialog?to=path"]]
""")
simlayers.available('x')
simlayers.new('Code Mode (Key: C)', 'code-mode', 'c', """
                [:y [:hs "code?key=y"]]
                [:u [:hs "code?key=u"]]
                [:i [:hs "code?key=i"]]
                [:o [:hs "code?key=o"]]
                [:p [:hs "code?key=p"]]
                [:open_bracket [:hs "code?key=open_bracket"]]
                [:close_bracket [:hs "code?key=close_bracket"]]

                [:h [:hs "code?key=h"]]
                [:j [:hs "code?key=j"]]
                [:k [:hs "code?key=k"]]
                [:l [:hs "code?key=l"]]
                [:semicolon [:hs "code?key=semicolon"]]
                [:quote [:hs "code?key=quote"]]
                [:return_or_enter [:hs "code?key=return_or_enter"]]

                [:b [:hs "code?key=b"]]

                [:n [:hs "code?key=n"]]
                [:m [:hs "code?key=m"]]
                [:comma [:hs "code?key=comma"]]
                [:period [:hs "code?key=period"]]
                [:slash [:hs "code?key=slash"]]

                [:spacebar [:hs "code?key=spacebar"]]
""")
simlayers.new('Vi Visual Mode (Key: V)', 'vi-visual-mode', 'v', """
                [:##j :!Sdown_arrow]
                [:##k :!Sup_arrow]
                [:##h :!Sleft_arrow]
                [:##l :!Sright_arrow]
                [:##b :!SOleft_arrow]
                [:##n :!SOleft_arrow]
                [:##w :!SOright_arrow]
                [:##0 :!SCleft_arrow]
                [:##4 :!SCright_arrow]
                [:##a :!SCright_arrow]
                [:##i :!SCleft_arrow]
                [:##open_bracket :!SOup_arrow]
                [:##close_bracket :!SOdown_arrow]
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

                [:z [:launch "zoom.us.app"]]
                [:x [:launch "Tinkerwell.app"]]
                [:c [:launch "Sublime Merge.app"]]
                [:v [:launch "TablePlus.app"]]
                [:b [:hs "launch-app?id=finder"]]

                [:spacebar [:hs "window-bringAllToFront"]]
""")
simlayers.new('App Mode (Key: .)', 'app-mode', 'period', """
                [:t [:hs "shortcut-trigger?key=T"]]
                [:r [:hs "shortcut-trigger?key=R"]]
                [:e [:hs "shortcut-trigger?key=E"]]
                [:w [:hs "shortcut-trigger?key=W"]]
                [:q [:hs "shortcut-trigger?key=Q"]]
                [:g [:hs "shortcut-trigger?key=G"]]
                [:f [:hs "shortcut-trigger?key=F"]]
                [:d [:hs "shortcut-trigger?key=D"]]
                [:s [:hs "shortcut-trigger?key=S"]]
                [:a [:hs "shortcut-trigger?key=A"]]
                [:b [:hs "shortcut-trigger?key=B"]]
                ; v
                [:c [:hs "shortcut-trigger?key=C"]]
                [:x [:hs "shortcut-trigger?key=X"]]
                [:z [:hs "shortcut-trigger?key=Z"]]
                [:h [:hs "shortcut-trigger?key=H"]]
                [:m [:hs "shortcut-trigger?key=M"]]
                [:0 :!OC0] ; Notion: Create text
                [:1 :!OC1] ; Notion: Create H1 heading
                [:2 :!OC2] ; Notion: Create H2 heading
                [:3 :!OC3] ; Notion: Create H3 heading
                [:4 [:hs "shortcut-trigger?key=4"]]
                [:5 :!OC5] ; Notion: Create bulleted list
                [:6 :!OC6] ; Notion: Create numbered list
                [:7 :!OC7] ; Notion: Create toggle list
                [:8 :!OC8] ; Notion: Create code block
""")
simlayers.new('Search Mode (Key: /)', 'search-mode', 'slash', """
                [:w [:hs "window-searchInCurrentApp"]]
                [:t [:hs "search-tabs"]]

                [:a [:hs "window-searchAll"]]
                [:s :!Cr] ; Search for symbol
                [:f [:alfredsearch "open "]] ; Search files
                [:g [:alfred "google" "com.akikoz.alfred.websearchsuggest"]]

                [:z [:alfred "amazon" "com.akikoz.alfred.websearchsuggest"]]
                [:c [:slash :!Scomma :!Scomma :!Scomma :!Scomma :!Scomma :return_or_enter]] ; Search for conflicts
""")

simlayers.new('Window Mode (Key: Spacebar)', 'window-mode', 'spacebar', """
                [:tab [:hs "window-moveToCenter"]]
                ; q
                ; w
                ; e
                ; r
                ; t

                ; y
                [:u [:hs "window-move?to=topLeft"]]
                [:i [:hs "window-moveToMiddle"]]
                [:o [:hs "window-move?to=topRight"]]
                [:p [:hs "window-appSettings"]]
                ; [
                [:close_bracket [:hs "window-moveTotopRightSmall"]]

                [:caps_lock :mission_control] ; Mac: Show all windows
                ; a
                ; s
                [:d [:hs "window-moveToNextDisplay"]]
                [:f [:hs "window-move?to=maximize"]]
                [:g [:hs "window-showGrid"]]

                [:h [:hs "window-move?to=leftHalf"]]
                [:j [:hs "window-move?to=bottomHalf"]]
                [:k [:hs "window-move?to=topHalf"]]
                [:l [:hs "window-move?to=rightHalf"]]
                [:semicolon [:hs "window-next"]]
                [:quote [:hs "window-nextInCurrentApp"]]
                [:return_or_enter [:hs "window-reset"]]

                ; z
                ; x
                ; c
                ; v
                [:b [:hs "window-toggleSidebar"]]

                [:n [:hs "window-move?to=bottomLeft"]]
                [:m [:hs "misc-moveMouseToOtherScreen"]]
                [:comma [:hs "window-move?to=bottomRight"]]
                ; .
                ; /
""")

compileTemplate(hyperMode, simlayers)
