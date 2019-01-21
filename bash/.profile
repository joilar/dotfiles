
# https://superuser.com/questions/789448/choosing-between-bashrc-profile-bash-profile-etc
# ~/.profile has the stuff NOT specifically related to bash, such as environment variables (PATH and friends)

# Add .local bins if not present
if [[ ! $PATH =~ "$HOME/.local/bin" ]]; then
    PATH=$HOME/.local/bin:$PATH
fi

# Add ~/bin if not present
if [[ ! $PATH =~ "$HOME/bin" ]]; then
    PATH=$HOME/bin:$PATH
fi

export PATH

