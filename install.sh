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

cd "$HOME"

cp -r "$ORDIR" "$HOME/.tohru"

cd "$HOME/.tohru"

chmod +x tohru.sh

echo ". . . DONE!"
