#!/bin/bash

function spinningBar() {
    tput civis
    itens=(\\ \| / -)

    printf "Working "
    while kill -0 "$PID" 2> /dev/null
    do
        for i in "${itens[@]}"
        do
            printf "%s\b" "$i"
            sleep 0.1
        done
    done

    printf " \n"

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
    cd "$HOME/TohruDownloads" || exit 1

    echo ; read -p "Insert the URL:" link

    read -p "do you want to download it into a directory? y/n:" CHOICE
    if [ "$CHOICE" = "y" ]; then
            read -p "Insert the directory name:" dirnam
            mkdir -p "$dirnam"
            cd "$dirnam" || echo "quitting" || exit 1

            youtube-dl -i -x --audio-format mp3 -o \
            '%(playlist_index)s-%(title)s.%(ext)s' \
            "$link" >> /dev/null & PID="$!"
    else
        youtube-dl -i -x --audio-format mp3 -o \
        '%(title)s.%(ext)s' "$link" >> /dev/null & PID="$!"
    fi

    spinningBar ; printf "Done!\n"

    read -p "Press q to quit or any key to download more songs:" EXT
    [ "$EXT" = "q" ] && exit 0
done
