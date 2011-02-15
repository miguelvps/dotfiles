xset r rate 300 # set keyboard repeat delay/rate
xrdb -merge ~/.Xresources

chromium &
urxvt -e irssi &
gvim &
urxvt &

exec ck-launch-session awesome 2> /tmp/awesome-error-output
