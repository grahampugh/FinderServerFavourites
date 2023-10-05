#!/bin/bash

: <<DOC
Launcher Script for FinderServerFavourites.py

Usage:
bash launcher.sh [--add|--remove] [--server *]
DOC

workdir="/Library/Management/FinderServerFavourites"

# bundled python directory
relocatable_python_path="$workdir/Python.framework/Versions/Current/bin/python3"

# obtain arguments
while test $# -gt 0 ; do
    case "$1" in
        -a|--add) mode="add"
            ;;
        -r|--remove) mode="remove"
            ;;
        -u|--user) 
            shift
            user="$1"
            ;;
        --server)
            shift
            server+=("$1")
            ;;
        -h|--help) show_help
            ;;
    esac
    shift
done

# set parameters
if [[ ! "$user" ]]; then
    user=$(/usr/sbin/scutil <<< "show State:/Users/ConsoleUser" | /usr/bin/awk -F': ' '/[[:space:]]+Name[[:space:]]:/ { if ( $2 != "loginwindow" ) { print $2 }}')
fi

# print settings
echo "User: $user"
echo "Mode: $mode"
echo "Servers: ${server[*]}"

# now call the script
"$relocatable_python_path" "$workdir/FinderServerFavourites.py" --user "$user" --mode "$mode" "${server[@]}"
