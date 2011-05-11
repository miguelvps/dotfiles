if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/* ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

xrdb -merge ~/.Xresources

xset r rate 300 # set keyboard repeat delay/rate

chromium &
urxvt -e irssi &
gvim &
urxvt &

exec ck-launch-session awesome
