# FinderServerFavourites

## Acknowledgements

This script is almost entirely based on the work of **[@Bretterteig](https://github.com/Bretterteig/jamf-tools/blob/master/Scripts/AddServerShareFavorites.py)**. This project is purely designed to package up the script with a suitable python distribution for anyone who does not push a generic python to all clients.

## Requirements

Whatever runs this script requires Full Disk Access. For example, if you are running from Terminal, you must enable Full Disk Access for Terminal in the Accessibility settings.

## Usage

Use the `launcher.sh` script to add servers directly from the command line.

    sudo /Library/Management/FinderServerFavourites/launcher.sh --add --server "smb://some.server" --server "smb://another-server.com"

You can specify an alternative user with the `--user SOMEUSER` argument.

## Usage with Jamf

Upload the script `Jamf-FinderServerFavourites.sh` to Jamf and add it to a policy which also has the supplied package attached. Set Parameter 4 to either `add` or `remove`, and use all the remaining parameters to specify servers.
