#!/bin/sh

# TR_APP_VERSION
# TR_TIME_LOCALTIME
# TR_TORRENT_DIR
# TR_TORRENT_HASH
# TR_TORRENT_ID
# TR_TORRENT_NAME

logo="/usr/share/transmission/web/images/graphics/logo.png"
notify-send --urgency=normal --icon=$logo "Transmission" "\n$TR_TORRENT_NAME finished\!\n"
