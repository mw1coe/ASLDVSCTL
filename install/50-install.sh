#!/usr/bin/env bash
#
# 50-install.sh
# Install ASL3 and DVSwitch Packages
#

set -e

echo "Installing application packages..."
echo

INSTALL_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "${INSTALL_DIR}/.." && pwd)"

source "${ROOT_DIR}/install/lib/packages.sh"

###############################################################################
# AllStarLink
###############################################################################

echo "AllStarLink Packages"
echo "--------------------"

install_package_list \
    "${ROOT_DIR}/config/packages/asl3.conf"

###############################################################################
# DVSwitch
###############################################################################

echo "DVSwitch Packages"
echo "-----------------"

install_package_list \
    "${ROOT_DIR}/config/packages/dvswitch.conf"

echo "Application package installation complete."
echo
