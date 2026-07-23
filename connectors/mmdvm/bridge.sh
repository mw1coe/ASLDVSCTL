#!/usr/bin/env bash
#
###############################################################################
# MMDVM_Bridge Configuration
###############################################################################

mmdvm_bridge_write_network()
{
    log_info "Writing MMDVM_Bridge network"

    ini_set "$MMDVM_INI" "DMR Network" "Address"  "$ADDRESS"
    ini_set "$MMDVM_INI" "DMR Network" "Port"     "$PORT"
    ini_set "$MMDVM_INI" "DMR Network" "Password" "$PASSWORD"
}

mmdvm_bridge_write_slot()
{
    case "${SLOT:-2}" in

        1)
            ini_set "$MMDVM_INI" "DMR Network" "Slot1" "1"
            ini_set "$MMDVM_INI" "DMR Network" "Slot2" "0"
            ;;

        *)
            ini_set "$MMDVM_INI" "DMR Network" "Slot1" "0"
            ini_set "$MMDVM_INI" "DMR Network" "Slot2" "1"
            ;;

    esac
}
