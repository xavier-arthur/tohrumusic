#!/bin/bash

ORDIR="$(dirname $(readlink -f $0))"

cat << EOF >> $HOME/.local/share/applications/tohru.desktop
[Desktop Entry]
Type=Application
Name=Tohru Music Downloader
Comment=Download music!
Exec=.tohru/tohru.sh
Icon=$HOME/.tohru/icon.png
Terminal=true
EOF

cp -r "$ORDIR" "$HOME/.tohru"
chmod +x "$HOME/.tohru/tohru.sh"
case "$1" in
    "rm")mv "$ORDIR" /tmp/tohru_debris;;
    "remove")mv "$ORDIR" /tmp/tohru_debris;;
esac
