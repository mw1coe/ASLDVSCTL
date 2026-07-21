#!/usr/bin/env bash
#
# 30-dvswitch.sh
# DVSwitch Repository - Phase 1
#

set -e

echo "Checking DVSwitch GPG key..."
echo

CONFIG_DIR="$(cd "$(dirname "$0")/../config" && pwd)"

source "${CONFIG_DIR}/sources.conf"

###############################################################################
# DVSwitch GPG Key
###############################################################################

download_key()
{
    echo "Downloading DVSwitch key..."

    mkdir -p "$(dirname "${DVSWITCH_KEY_FILE}")"

wget -q -O "${DVSWITCH_KEY_FILE}" "${DVSWITCH_KEY_URL}"

    echo "  [OK] DVSwitch key installed."
    echo
}

if [[ ! -f "${DVSWITCH_KEY_FILE}" ]]; then

    download_key

else

    if gpg --show-keys "${DVSWITCH_KEY_FILE}" 2>/dev/null | grep -q "${DVSWITCH_KEY_ID}"; then

        echo "  [OK] Valid DVSwitch key installed."
        echo

    else

        echo "  Existing key is invalid."
        rm -f "${DVSWITCH_KEY_FILE}"
        download_key

    fi

fi

###############################################################################
# Configure Repository
###############################################################################

REPO_FILE="/etc/apt/sources.list.d/dvswitch.list"

REPO_LINE="deb [signed-by=${DVSWITCH_KEY_FILE}] ${DVSWITCH_REPO_BASE} ${DVSWITCH_REPO_DIST} ${DVSWITCH_REPO_COMPONENT}"

echo "Checking DVSwitch repository..."

if [[ -f "$REPO_FILE" ]]; then

    if grep -Fxq "$REPO_LINE" "$REPO_FILE"
    then
        echo "  [OK] Repository already configured."
        echo
        exit 0
    fi

    echo "  Updating repository configuration..."

else

    echo "  Creating repository configuration..."

fi

cat > "$REPO_FILE" <<EOF
# Official DVSwitch Repository
$REPO_LINE
EOF

echo "  Repository configured."
echo
