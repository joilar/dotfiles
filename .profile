
# https://superuser.com/questions/789448/choosing-between-bashrc-profile-bash-profile-etc
# ~/.profile has the stuff NOT specifically related to bash, such as environment variables (PATH and friends)

if [[ $PATH != *$HOME/bin:* ]]; then
    PATH=$HOME/bin:$HOME/.files/bin:$PATH
fi

if [[ $PATH != *$HOME/.files/bin:* ]]; then
    PATH=$HOME/.files/bin:$PATH
fi

export PATH

