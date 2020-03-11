#!/bin/bash

cat << EOF >> $HOME/.local/share/applications/tohru.desktop
[Desktop Entry]
Type=Application
Name=Tohru Music Downloader
Comment=Download music!
Exec=.tohru/tohru.sh
Icon=$HOME/.tohru/icon.png
Terminal=true
EOF
