# Syntax
#      notify-send [OPTIONS] [body]
#
#  Key
#   -u, --urgency=LEVEL
#               The urgency level (low,  normal,  critical).
#
#   -t, --expire-time=TIME
#               The  timeout in milliseconds at which to expire the
#               notification.
#
#   -i, --icon=ICON[,ICON...]
#               An icon filename or stock icon to display.
#
#   -c, --category=TYPE[,TYPE...]
#               Specifies the notification category.
#
#   -?, --help
#               Show a help message
#
#   -h, --hint=TYPE:NAME:VALUE
#               Pass extra data. Valid TYPEs are int, double, string and byte.
#
#
#
# TR_APP_VERSION
# TR_TIME_LOCALTIME
# TR_TORRENT_DIR
# TR_TORRENT_HASH
# TR_TORRENT_ID
# TR_TORRENT_NAME

logo="/usr/share/transmission/web/images/graphics/logo.png"
notify-send --urgency=normal --icon=$logo "Transmission" "\n$TR_TORRENT_NAME finished!\n$TRANSMISSION_WEB_HOME"
