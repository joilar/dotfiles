
# https://superuser.com/questions/789448/choosing-between-bashrc-profile-bash-profile-etc
# ~/.bashrc has anything you'd want at an interactive command line. Command prompt, EDITOR variable, bash aliases for my use

# Aliases

alias resource='source ~/.bash_profile'

alias ..='cd ..'
alias ...='cd ../..'
alias ll='ls -lh'
alias la='ll -a'

alias files='cd ~/.files'
alias repos='cd ~/repos'

alias edit_shell='vim ~/.files/.bashrc; resource'
alias esh='edit_shell'

# Variables

export EDITOR=/usr/bin/vim


