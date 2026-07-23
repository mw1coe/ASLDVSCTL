#!/usr/bin/env bash
#
###############################################################################
# MMDVM Configuration Generator
###############################################################################

connector_generate_network()
{
    mmdvm_bridge_write_network
}

connector_generate_runtime()
{
    mmdvm_bridge_write_slot
    analog_bridge_write
}

###############################################################################
# MMDVM_Bridge - Network
###############################################################################

mmdvm_bridge_write_network()
{
    log_info "Updating MMDVM_Bridge"

    ini_set "$MMDVM_INI" "DMR Network" "Address" "$ADDRESS"
    ini_set "$MMDVM_INI" "DMR Network" "Port" "$PORT"
    ini_set "$MMDVM_INI" "DMR Network" "Password" "$PASSWORD"
}

###############################################################################
# MMDVM_Bridge - Slot
###############################################################################

mmdvm_bridge_write_slot()
{
    [[ -n "${SLOT:-}" ]] || return 0

    log_info "Updating MMDVM_Bridge"

    case "$SLOT" in
        1)
            ini_set "$MMDVM_INI" "DMR Network" "Slot1" 1
            ini_set "$MMDVM_INI" "DMR Network" "Slot2" 0
            ;;
        2)
            ini_set "$MMDVM_INI" "DMR Network" "Slot1" 0
            ini_set "$MMDVM_INI" "DMR Network" "Slot2" 1
            ;;
    esac
}

###############################################################################
# Analog_Bridge
###############################################################################

analog_bridge_write()
{
    log_info "Updating Analog_Bridge"

    if [[ -n "${TG:-}" ]]; then
        ini_set "$ANALOG_INI" "AMBE_AUDIO" "txTg" "$TG"
    fi

    if [[ -n "${SLOT:-}" ]]; then
        ini_set "$ANALOG_INI" "AMBE_AUDIO" "txTs" "$SLOT"
    fi
}

