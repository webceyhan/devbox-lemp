

###########################################################################################
# VAGRANT-PATCH
###########################################################################################

# enable bash completion in interactive shells
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# enable colored prompt for all users
force_color_prompt=yes

# enable colored GCC warnings and errors for all users
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# define global aliases
alias '..'='cd ..'
alias '...'='cd /'
alias 'll'='ls -alF'
alias 'la'='ls -A'
alias 'cls'='clear'
alias 'mod'='stat -c "%a %n"'
