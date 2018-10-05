setopt HIST_IGNORE_ALL_DUPS
export LSCOLORS="exfxcxdxbxegedabagacad"
unsetopt auto_pushd
export LESS="-g -i -M -R -w -z-4"

# Used for cmd-j and cmd-l key bindings in iTerm using "Send Escape Sequence"
bindkey "^[j" forward-word
bindkey "^[l" end-of-line
