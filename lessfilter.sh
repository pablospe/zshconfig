#! /usr/bin/env sh
# this is a example of .lessfilter, you can change it
mime=$(file -bL --mime-type "$1")
category=${mime%%/*}
kind=${mime##*/}
if [ -d "$1" ]; then
    if hash exa 2>/dev/null; then
        exa -1 --group-directories-first --color=always --icons "$1"
    else
        ls -1 --group-directories-first --color=always "$1"
    fi
elif [ "$category" = image ]; then
    chafa "$1"
    exiftool "$1"
elif [ "$kind" = vnd.openxmlformats-officedocument.spreadsheetml.sheet ] ||
    [ "$kind" = vnd.ms-excel ]; then
    in2csv "$1" | xsv table | bat -ltsv --color=always
elif [ "$category" = text ]; then
    bat --plain --color=always "$1"
else
    lesspipe "$1" | bat --color=always
fi
# lesspipe don't use exa, bat and chafa, it use ls and exiftool. so we create a lessfilter.
