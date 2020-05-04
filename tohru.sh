#!/bin/bash

function spinningBar() {
    tput civis -- invisible
    itens=(\\ \| / -)
    WRK='Working  '

    echo -n "$WRK"
    while kill -0 $PID 2> /dev/null
    do
        for i in "${itens[@]}"
        do
            printf "%s\b"$i
            sleep 0.1
        done
    done

    seq 1 ${#WRK} | while read i
        do
            echo -en "\b \b"
        done

    tput cnorm
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
    if [ "$CHOICE" = "y" ]; then
            read -p "Insert the directory name:" DIRNAM
            mkdir -p "$DIRNAM"
            cd "$DIRNAM"

            youtube-dl -i -x --audio-format mp3 --embed-thumbnail -o \
            '%(playlist_index)s-%(title)s.%(ext)s' \
            "$LINK" >> /dev/null & PID="$!"
    else
        youtube-dl -i -x --audio-format mp3 --embed-thumbnail -o \
        '%(title)s.%(ext)s' "$LINK" >> /dev/null & PID="$!"
    fi

    spinningBar ; echo -e "Done!"

    read -p "Press q to quit or any key to download more songs:" EXT
    [ "$EXT" = "q" ] && exit 0
done
