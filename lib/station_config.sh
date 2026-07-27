#!/usr/bin/env bash
#
# ASLDVSCTL
# Station Configuration Library
#

[[ -n "${ASLDVSCTL_STATION_CONFIG_LOADED:-}" ]] && return
readonly ASLDVSCTL_STATION_CONFIG_LOADED=1

station_set()
{
    local field="$1"
    local value="$2"

    case "$field" in
        callsign)
            config_set CALLSIGN "$value"
            ;;

        node)
            config_set NODE "$value"
            ;;

        dmrid)
            config_set DMR_ID "$value"
            ;;

        usrp)
            config_set USRP_NODE "$value"
            ;;

        *)
            log_error "Unknown station field: $field"
            return 1
            ;;
    esac || return 1

    log_info "Updated ${field}"

    return 0
}

###############################################################################
# Validate Station
###############################################################################

station_validate()
{
    printf "Station Validation\n"
    printf "%s\n" "------------------"

    if config_validate CALLSIGN "$CALLSIGN"
    then
        printf "PASS  Callsign\n"
    else
        printf "FAIL  Callsign\n"
    fi

    if config_validate NODE "$NODE"
    then
        printf "PASS  Node\n"
    else
        printf "FAIL  Node\n"
    fi

    if config_validate DMR_ID "$DMR_ID"
    then
        printf "PASS  DMR ID\n"
    else
        printf "FAIL  DMR ID\n"
    fi

    if config_validate USRP_NODE "$USRP_NODE"
    then
        printf "PASS  USRP Node\n"
    else
        printf "FAIL  USRP Node\n"
    fi
}


