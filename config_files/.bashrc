#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

command_not_found_handle() {
    if [[ -x "$(command -v pkgfile)" ]]; then
        echo "Command '$1' not found. Perhaps you meant:"
        pkgfile -si "$1"
    else
        echo "Command '$1' not found."
        return 127
    fi
}