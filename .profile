PAGER=less
export PAGER

EDITOR=vim
export EDITOR

VISUAL=gvim
export VISUAL

BROWSER=chromium
export BROWSER


if [[ -z $DISPLAY && $(tty) = /dev/tty1 ]]; then
    exec xinit
fi
