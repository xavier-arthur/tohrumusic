#!/bin/bash

function spinner() {
    tput civis -- invisible
    printf "["
    # While process is running...
    while kill -0 $PID 2> /dev/null; do
        printf  "▓"
        sleep 1
    done
    printf "]"
    echo "Done!"
    tput cnorm -- normal
}

cat << EOF
 _____      _                                   _
/__   \___ | |__  _ __ _   _    /\/\  _   _ ___(_) ___
  / /\/ _ \| '_ \| '__| | | |  /    \| | | / __| |/ __|
 / / | (_) | | | | |  | |_| | / /\/\ \ |_| \__ \ | (__
 \/   \___/|_| |_|_|   \__,_| \/    \/\__,_|___/_|\___|
EOF

[ -d "$HOME/TohruDownloads" ] || mkdir "$HOME/TohruDownloads"

while true;
do
    cd "$HOME/TohruDownloads"

    echo ; read -p "Insert the URL:" LINK

    read -p "do you want to download it into a directory? y/n:" CHOICE
    if [ "$CHOICE" == "y" ]; then
            read -p "Insert the directory name:" DIRNAM
            mkdir -p "$DIRNAM"
            cd "$DIRNAM"
    fi

    if [[ "$CHOICE" == "y" ]]; then
        youtube-dl -i -x --audio-format mp3 --embed-thumbnail -o \
        '%(playlist_index)s-%(title)s.%(ext)s' \
        $LINK >> /dev/null & PID=$!
    else
        youtube-dl -i -x --audio-format mp3 --embed-thumbnail -o \
        '%(title)s.%(ext)s' $LINK >> /dev/null & PID=$!
    fi

    spinner

    read -p "Press q to quit or any key to download more songs:" EXT
    [ "$EXT" == "q" ] && exit 0
done
