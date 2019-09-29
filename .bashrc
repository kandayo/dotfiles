export EDITOR=vim
export VISUAL=vim

export HISTCONTROL='erasedups:ignoreboth'
export HISTFILESIZE=-1
export HISTSIZE=-1
export PROMPT_COMMAND='history -a'

export PATH="$PATH:$HOME/.local/bin"

export PASSWORD_STORE_CLIP_TIME=60
export PASSWORD_STORE_DIR=~/.pw
export PASSWORD_STORE_GENERATED_LENGTH=72

export WALLPAPER_PATH=~/.config/wallpaper.jpg

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
source ~/.private
source ~/.functions

# sexy bash prompt
export PROMPT_USER_COLOR="$(tput bold)$(tput setaf 104)"
export PROMPT_DEVICE_COLOR="$(tput bold)$(tput setaf 104)"
export PROMPT_DIR_COLOR="$(tput bold)$(tput setaf 104)"
export PROMPT_GIT_STATUS_COLOR="$(tput bold)$(tput setaf 104)"
export PROMPT_SYMBOL=»
source ~/.bash_prompt

# nvm
nodesetup() {
  export NVM_DIR="$HOME/.nvm"
  source "$NVM_DIR/nvm.sh"
  source "$NVM_DIR/bash_completion"
}

# dircolors
eval "$(dircolors ~/.dir_colors)"
# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
# direnv
eval "$(direnv hook bash)"
