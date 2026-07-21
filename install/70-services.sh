#!/usr/bin/env bash
#
# 70-services.sh
#

set -e

echo "Starting services..."
echo

INSTALL_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "${INSTALL_DIR}/.." && pwd)"

source "${ROOT_DIR}/install/lib/services.sh"

service_manage asterisk
service_manage analog_bridge
service_manage mmdvm_bridge
service_manage md380-emu

echo
echo "Service stage complete."
