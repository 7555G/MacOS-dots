#
# ~/.bash_profile
#

# vim: set ft=sh:

# if not running interactively, don't do anything
case $- in
    *i*)
        ;;
    *)
        return
        ;;
esac

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# instantly append to history every command
export PROMPT_COMMAND="history -a; "

# notify terminal of current working directory#
export PROMPT_COMMAND+='echo -ne "\033]0;$(dirs +0)\007"; '

# check if this is a ssh session
if [[ -n "${SSH_CLIENT}" ]] || [[ -n "${SSH_TTY}" ]]; then
    SESSION_TYPE="remote_ssh"
else
    case $(ps -o comm= -p $PPID) in
        sshd|*/sshd) SESSION_TYPE="remote_ssh";;
    esac
fi

# local ip shortcuts
export imac="192.168.1.2"
export npower_pi="root@192.168.1.20"

# set the locale to English
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

# homebrew path
if [[ -z "${HOMEBREW_PREFIX}" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# append extra paths from files
source ~/.dotfiles/bin/append_paths ~/.dotfiles/extra_paths

# use homebrew bash
export SHELL="$(which bash)"

# use clang and Ninja with CMake
export CC="$(which clang)"
export CXX="${CC}++"
export CMAKE_GENERATOR="Ninja"

# custom prompt
if [[ -f ~/.bash_prompt ]]; then
    source ~/.bash_prompt
fi

# aliases
export TRASH="${HOME}/.Trash"
if [[ -f ~/.bash_aliases ]]; then
    source ~/.bash_aliases
fi

# conda initialization
if [[ -f ~/.conda_init ]]; then
    source ~/.conda_init
fi

source ~/.dotfiles/bin/source_dirs_list ~/.dotfiles/completion_dirs
