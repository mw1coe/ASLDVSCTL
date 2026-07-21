#!/usr/bin/env bash
#
# 80-verify.sh
#

set -e

echo "========================================"
echo " Verification"
echo "========================================"
echo

INSTALL_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "${INSTALL_DIR}/.." && pwd)"

source "${ROOT_DIR}/install/lib/detect.sh"

echo "Configuration Files"
echo "-------------------"

detect_file /etc/asterisk/rpt.conf
detect_file /etc/asterisk/iax.conf
detect_file /etc/asterisk/extensions.conf

detect_file /opt/MMDVM_Bridge/MMDVM_Bridge.ini
detect_file /opt/Analog_Bridge/Analog_Bridge.ini
detect_file /opt/MMDVM_Bridge/DVSwitch.ini

echo

echo "Packages"
echo "--------"

detect_package asl3
detect_package dvswitch-server

echo

echo "Services"
echo "--------"

detect_service asterisk
detect_service analog_bridge
detect_service mmdvm_bridge
detect_service md380-emu

echo
echo "Verification complete."
echo

