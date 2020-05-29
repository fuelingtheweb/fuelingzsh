function fileContents() {
    cat "$HOME/.fuelingzsh/karabiner/goku/$1.edn"
}
SETUP_EDN=$(fileContents 'setup')
VIM_EDN=$(fileContents 'vim')
MAIN_EDN=$(fileContents 'main')
echo "
;; !  | means mandatory
;; #  | means optional
;; C  | left_command
;; T  | left_control
;; O  | left_option
;; S  | left_shift
;; F  | fn
;; Q  | right_command
;; W  | right_control
;; E  | right_option
;; R  | right_shift
;; !! | mandatory command + control + option + shift (hyper)
;; ## | optional any

{
$SETUP_EDN
    :main [
        ;; each manipulator has a description and multiple rules

        ;;{:des \"...\"                               ;; -> description
        ;; :rules[
        ;;          [<from>  <to>  <conditions> <other options>]    ;; -> rule 1
        ;;          [<from>  <to>  <conditions> <other options>]    ;; -> rule 2
        ;; ]}
        ;;
        ;; <from> can be keywords defined in froms or keycodes without {:not-from true}
        ;; <to> can be keywords defined in tos, keycodes without {:not-to true} or strings (shell script)
        ;; <conditions> can be keywords defined in layers, devices, applications
        ;; <other options> {:other {:parameters {:to_delayed_action_delay_milliseconds 100 :basic.to_if_alone_timeout_milliseconds 500 :basic.to_if_held_down_threshold_milliseconds 250}} }

        ;; if simplified modifier is used in <to>, optional(#) definition will be ignored.

        ;; (custom variables) & modifiers -> Advanced
        ;; https://github.com/yqrashawn/GokuRakuJoudo/blob/master/examples.org#custom-variable
$MAIN_EDN
$VIM_EDN
    ]
}
" > $HOME/.fuelingzsh/karabiner/karabiner.edn

echo 'Success!'
