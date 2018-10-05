export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(code {})+abort'"

[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

# yellow: #e9e16d, green: #5cf19f
export FZF_DEFAULT_OPTS='
    --color fg:250,hl:#e9e16d,fg+:15,hl+:#5cf19f
    --color info:67,prompt:#e9e16d,spinner:67,pointer:#5cf19f,marker:#5cf19f
'
