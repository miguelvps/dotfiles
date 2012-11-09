PATH=$PATH:~/.bin
export PATH

PAGER=less
export PAGER

EDITOR=vim
export EDITOR

VISUAL=gvim
export VISUAL

BROWSER=chromium
export BROWSER

# Less colors for man pages
export LESS_TERMCAP_mb=$'\E[5;37m'  # begin blinking
export LESS_TERMCAP_md=$'\E[1;37m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'     # end mode
export LESS_TERMCAP_so=$'\E[7m'     # begin standout-mode - info box
export LESS_TERMCAP_se=$'\E[0m'     # end standout-mode
export LESS_TERMCAP_us=$'\E[36m'    # begin underline
export LESS_TERMCAP_ue=$'\E[0m'     # end underline

if [[ -z $DISPLAY && $(tty) = /dev/tty1 ]]; then
    exec xinit -- vt7
fi
