#!/usr/bin/env bash

[[ -n "${ASLDVSCTL_CONFIGURE_LOADED:-}" ]] && return
readonly ASLDVSCTL_CONFIGURE_LOADED=1

source "${LIB_DIR}/common.sh"
source "${LIB_DIR}/logging.sh"

configure_profile() {

    case "$MODE" in

        DMR)
            configure_dmr
            ;;

        YSF)
            configure_ysf
            ;;

        NXDN)
            configure_nxdn
            ;;

        P25)
            configure_p25
            ;;

        M17)
            configure_m17
            ;;

        *)
            log_error "Unsupported MODE '$MODE'"
            return 1
            ;;
    esac
}
