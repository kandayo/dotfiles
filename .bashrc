export EDITOR=vim
export VISUAL=vim

export HISTCONTROL='erasedups:ignoreboth'
export HISTFILESIZE=-1
export HISTSIZE=-1
export PROMPT_COMMAND='history -a'

export PATH="${HOME}/.rbenv/bin:${PATH}"

export PATH="${PATH}:/opt/openresty/bin"
export PATH="${PATH}:${HOME}/.local/bin"

export PASSWORD_STORE_CLIP_TIME=60
export PASSWORD_STORE_DIR=~/.pw
export PASSWORD_STORE_GENERATED_LENGTH=72

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[C": forward-char'
bind '"\e[D": backward-char'

bind 'set bell-style none'
bind 'set colored-completion-prefix on'
bind 'set completion-ignore-case on'
bind 'set completion-map-case on'

shopt -s autocd cdspell direxpand dirspell xpg_echo histappend cmdhist

source ~/.aliases
source ~/.functions
source ~/.prompt

# git aware prompt
export GIT_PROMPT_ONLY_IN_REPO=1
export GIT_PROMPT_THEME="Single_line_Dark"
source "${HOME}/.bash-git-prompt/gitprompt.sh"

# nvm
export NVM_DIR="${HOME}/.nvm"
source "${NVM_DIR}/nvm.sh"
source "${NVM_DIR}/bash_completion"

# dircolors
eval "$(dircolors ~/.dir_colors)"
# luarocks
eval "$(luarocks path --bin)"
# rbenv
eval "$(rbenv init -)"
# direnv
eval "$(direnv hook bash)"
