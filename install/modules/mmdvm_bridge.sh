#!/usr/bin/env bash
#
# MMDVM_Bridge Configuration Module
#

source "${ROOT_DIR}/lib/ini.sh"
source "${ROOT_DIR}/install/lib/paths.sh"

[[ -n "${ASLDVSCTL_MODULE_MMDVM_LOADED:-}" ]] && return
readonly ASLDVSCTL_MODULE_MMDVM_LOADED=1

###############################################################################
# Configure MMDVM_Bridge
###############################################################################

configure_mmdvm_bridge()
{
    echo
    echo "MMDVM_Bridge"
    echo "-------------"

    [[ -f "$MMDVM_BRIDGE_INI" ]] || {
        echo "ERROR: $MMDVM_BRIDGE_INI not found."
        return 1
    }

local address
local port
local local_port
local slot1
local slot2
local options

address=$(ini_get "$MMDVM_BRIDGE_INI" "DMR Network" "Address")
port=$(ini_get "$MMDVM_BRIDGE_INI" "DMR Network" "Port")
local_port=$(ini_get "$MMDVM_BRIDGE_INI" "DMR Network" "Local")
slot1=$(ini_get "$MMDVM_BRIDGE_INI" "DMR Network" "Slot1")
slot2=$(ini_get "$MMDVM_BRIDGE_INI" "DMR Network" "Slot2")
options=$(ini_get "$MMDVM_BRIDGE_INI" "DMR Network" "Options")

printf "  Address    : %s\n" "$address"
printf "  Port       : %s\n" "$port"
printf "  Local Port : %s\n" "$local_port"
printf "  Slot 1     : %s\n" "$slot1"
printf "  Slot 2     : %s\n" "$slot2"
printf "  Options    : %s\n" "${options:-<none>}"

echo

}
