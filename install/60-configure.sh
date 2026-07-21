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

source "${ROOT_DIR}/install/lib/paths.sh"
source "${ROOT_DIR}/install/lib/detect.sh"
source "${ROOT_DIR}/install/lib/backup.sh"
source "${ROOT_DIR}/install/modules/mmdvm_bridge.sh"
source "${ROOT_DIR}/install/lib/transaction.sh"

echo "Checking configuration files..."
echo

detect_file "$RPT_CONF"
detect_file "$IAX_CONF"
detect_file "$EXTENSIONS_CONF"

echo

detect_file "$MMDVM_BRIDGE_INI"
detect_file "$ANALOG_BRIDGE_INI"
detect_file "$DVSWITCH_INI"

echo
echo "Creating backups..."
echo

backup_file "$RPT_CONF"
backup_file "$IAX_CONF"
backup_file "$EXTENSIONS_CONF"

backup_file "$MMDVM_BRIDGE_INI"
backup_file "$ANALOG_BRIDGE_INI"
backup_file "$DVSWITCH_INI"

echo

echo

transaction_begin

configure_mmdvm_bridge

transaction_end

echo "Configuration stage complete."
echo
