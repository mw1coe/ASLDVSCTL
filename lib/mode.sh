#!/usr/bin/env bash
#
###############################################################################
# ASLDVSCTL
# Mode Library
###############################################################################

[[ -n "${ASLDVSCTL_MODE_LOADED:-}" ]] && return
readonly ASLDVSCTL_MODE_LOADED=1

mode_list()
{
    printf "Available Modes\n"
    printf "%s\n" "---------------"

    printf "DMR\n"
    printf "M17\n"
    printf "YSF\n"
    printf "P25\n"
    printf "NXDN\n"

    return 0
}

mode_show()
{
    state_load >/dev/null 2>&1 || true

    printf "Mode\n"
    printf "%s\n" "----"

    printf "Current   : %s\n" "${MODE:-Unknown}"
    printf "Profile   : %s\n" "${PROFILE:-None}"
    printf "Connector : %s\n" "${CONNECTOR:-None}"

    return 0
}

mode_set()
{
    [[ $# -eq 1 ]] || {
        log_error "Usage: mode_set <mode>"
        return 1
    }

    local mode="${1^^}"

    mode_exists "$mode" || {
        log_error "Unsupported mode: $mode"
        return 1
    }

    case "$mode" in
        DMR)
            connector_load mmdvm || return 1
            ;;
        M17)
            connector_load m17 || return 1
            ;;
        YSF)
            connector_load ysf || return 1
            ;;
        P25)
            connector_load p25 || return 1
            ;;
        NXDN)
            connector_load nxdn || return 1
            ;;
    esac

    MODE="$mode"

    state_save || return 1

    log_info "Mode changed to ${MODE}"

    return 0
}

