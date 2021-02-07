if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/* ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

xrdb -merge ~/.Xresources

# export XCURSOR_PATH='' # use default x cursor

eval $(ssh-agent)

exec i3
