# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  z
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# GIT ALIASES
alias s="git status"
alias a="git add ."
alias c="git commit"
alias p="git push"
alias gl="git log"
alias glo="git log --oneline"
alias gd="git diff ."
alias gds="git diff --staged ."

# SHORTCUT COMMANDS
alias ports="sudo lsof -i -P -n | grep LISTEN"
alias docker-down="sudo chmod 666 /var/run/docker.sock"
alias win="tmux rename-window"
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# APPLICATIONS
alias v="nvim"
alias t="tmux"
alias store="~/Tools/pling-store-5.0.2-1-x86_64.AppImage"

# OTHER
alias l="logo-ls -l"
alias ll="logo-ls -la"
alias config="nvim ~/.zshrc"
alias sconfig="source ~/.zshrc"
alias x="exit"
alias open="xdg-open"
alias restart-audio="systemctl restart --user pulseaudio"
alias clear-cache="paccache -rk2 && paccache -ruk1 && paccache -rk2 -c ~/.cache/yay/*/ && paccache -ruk0 ~/.cache/yay/*/"
alias anime="~/Tools/ani-cli/bin/ani-cli"
alias rice="curl -L rum.sh/ricebowl"

# CUSTOM FUNCTIONS
function squash(){
    it reset $(git merge-base master $(git branch --show-current))
}

function clean(){
  PACMAN_CACHE=$(pacman -Qtdq)
  YAY_CACHE=$(yay -Qtdq)

  if [[ -n $PACMAN_CACHE ]]; then
    sudo pacman -Rns $(pacman -Qtdq) 
  else
    echo "\n🫧 No [pacman] unneeded packages"
  fi 

  if [[ -z PACMAN_CACHE ]]; then
    yay -Rns $(yay -Qtdq)
  else
    echo "🫧 No [yay] unneeded packages\n"
  fi 

  clear-cache

  echo "\n🛀 All clean"
}

function help(){
  curl cheat.sh/$1
}

function kill-port(){
  sudo kill -9 $(sudo lsof -t -i:$1)
}

# export FZF_DEFAULT_COMMAND="nvim"
export FZF_DEFAULT_OPTS='--border --preview "bat {}" '
export PATH="$PATH:$HOME/.config/composer/vendor/bin"

source /usr/share/nvm/init-nvm.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Disable warning about zsh prompt
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
neofetch --ascii --source /home/abeldlp/Tools/pikachu3.txt --ascii_colors 3 5 6 2

