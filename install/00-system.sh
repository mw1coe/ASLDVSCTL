#!/usr/bin/env bash
#
# 60-configure.sh
#

set -e

echo "Configuring system..."
echo

INSTALL_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "${INSTALL_DIR}/.." && pwd)"

source "${ROOT_DIR}/install/lib/configure.sh"

echo "Configuration stage complete."
echo
