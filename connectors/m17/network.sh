#!/usr/bin/env bash
#
###############################################################################
# USRP2M17 Network Configuration
###############################################################################

usrp2m17_write_network()
{

[[ -f "$USRP2M17_INI" ]] || {
    log_error "USRP2M17 configuration not found: $USRP2M17_INI"
    return 1
}

    log_info "Updating USRP2M17"

    [[ -n "${CALLSIGN:-}" ]] && \
        ini_set "$USRP2M17_INI" "M17 Network" "Callsign" "$CALLSIGN"

    [[ -n "${ADDRESS:-}" ]] && \
        ini_set "$USRP2M17_INI" "M17 Network" "Address" "$ADDRESS"

    if [[ -n "${REFLECTOR:-}" && -n "${MODULE:-}" ]]; then
        ini_set "$USRP2M17_INI" \
            "M17 Network" \
            "Name" \
            "${REFLECTOR} ${MODULE}"
    fi

    [[ -n "${PORT:-}" ]] && \
        ini_set "$USRP2M17_INI" "M17 Network" "DstPort" "$PORT"

    [[ -n "${LOCAL_PORT:-}" ]] && \
        ini_set "$USRP2M17_INI" "M17 Network" "LocalPort" "$LOCAL_PORT"
}
