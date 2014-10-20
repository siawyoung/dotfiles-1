alias ll="ls -lahL"
alias con="tail -40 -f /var/log/system.log"
alias dev="cd ~/dev/"

bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

export EDITOR="vim"
export CLICOLOR=1
export XCODE="`xcode-select --print-path`"
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:~/bin