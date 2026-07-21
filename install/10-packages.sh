#!/usr/bin/env bash
#
# 10-packages.sh
# Install Core Packages
#

set -e

echo "Checking core packages..."
echo

INSTALL_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "${INSTALL_DIR}/.." && pwd)"

source "${ROOT_DIR}/install/lib/packages.sh"

install_package_list \
    "${ROOT_DIR}/config/packages/core.conf"

echo "Core package stage complete."
echo
