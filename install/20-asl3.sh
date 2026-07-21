#!/usr/bin/env bash
#
# 20-asl3.sh
# Install AllStarLink Repository
#

set -e

echo "Checking AllStarLink repository..."
echo

CONFIG_DIR="$(cd "$(dirname "$0")/../config" && pwd)"

source /etc/os-release
source "${CONFIG_DIR}/sources.conf"

case "$VERSION_ID" in
    12)
        REPO_FILE="asl-apt-repos.deb12_all.deb"
        ;;
    13)
        REPO_FILE="asl-apt-repos.deb13_all.deb"
        ;;
    *)
        echo "[FAIL] Unsupported Debian version: $VERSION_ID"
        exit 1
        ;;
esac

REPO_URL="https://repo.allstarlink.org/public/${REPO_FILE}"

#
# Already installed?
#

if dpkg -s asl-apt-repos >/dev/null 2>&1
then
    echo "  [OK] AllStarLink repository already installed."
    echo
    exit 0
fi

echo "Downloading:"
echo "  ${REPO_URL}"
echo

cd /tmp

wget -q -O "$REPO_FILE" "$REPO_URL"

echo "Installing repository..."

dpkg -i "$REPO_FILE"

echo

echo "AllStarLink repository installed."
echo
