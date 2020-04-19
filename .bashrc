export EDITOR=vim
export VISUAL=vim

export HISTCONTROL='erasedups:ignoreboth'
export HISTFILESIZE=-1
export HISTSIZE=-1
export PROMPT_COMMAND='history -a'

export PATH="$PATH:$HOME/.local/bin"

export WALLPAPER_PATH=~/.config/wallpaper.png

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

# sexy-bash-prompt
# Bash prompt with colors, git statuses, and git branches.
#
# https://github.com/twolfson/sexy-bash-prompt
export PROMPT_USER_COLOR="$(tput bold)$(tput setaf 104)"
export PROMPT_DEVICE_COLOR="$(tput bold)$(tput setaf 104)"
export PROMPT_DIR_COLOR="$(tput bold)$(tput setaf 104)"
export PROMPT_GIT_STATUS_COLOR="$(tput bold)$(tput setaf 104)"
export PROMPT_SYMBOL=»
source ~/.bash_prompt

# dircolors
# An arctic, north-bluish clean and elegant dircolors theme.
#
# https://github.com/arcticicestudio/nord-dircolors
eval "$(dircolors ~/.dir_colors)"

# direnv
# Unclutter your .profile.
#
# https://github.com/direnv/direnv
eval "$(direnv hook bash)"

# asdf-vm
# Extendable version manager with support for Ruby, Node.js, Elixir, Erlang...
#
# https://github.com/asdf-vm/asdf
source $HOME/.asdf/asdf.sh
source $HOME/.asdf/completions/asdf.bash

export TERM=rxvt-unicode-256color
stty -ixon
