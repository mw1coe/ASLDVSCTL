#!/usr/bin/env bash
#
# ASLDVSCTL Universal Installer
#

###############################################################################
# Standard PATH
###############################################################################

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH"

set -e

BASE="$(cd "$(dirname "$0")" && pwd)"

echo
echo "====================================="
echo " ASLDVSCTL Universal Installer"
echo "====================================="
echo

for script in "$BASE"/install/*.sh
do
    echo "==> $(basename "$script")"
    bash "$script"
    echo
done

echo "Installation Complete."
