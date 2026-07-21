#!/usr/bin/env bash
#
# ASLDVSCTL 2.0
# Bridge Management Library
#

[[ -n "${ASLDVSCTL_BRIDGE_LOADED:-}" ]] && return
readonly ASLDVSCTL_BRIDGE_LOADED=1

###############################################################################
# Configure Dispatcher
###############################################################################

bridge_configure() {

    case "${MODE:-}" in

        DMR)
            bridge_configure_dmr
            ;;

        YSF)
            bridge_configure_ysf
            ;;

        NXDN)
            bridge_configure_nxdn
            ;;

        P25)
            bridge_configure_p25
            ;;

        M17)
            bridge_configure_m17
            ;;

        *)
            log_error "Unsupported MODE '${MODE:-}'"
            return 1
            ;;

    esac
}

###############################################################################
# DMR
###############################################################################

bridge_configure_dmr() {

    log_info "Configuring DMR"

    bridge_write_mmdvm
    bridge_write_analog
    bridge_write_dvswitch
}

###############################################################################
# Future Modes
###############################################################################

bridge_configure_ysf() {
    log_warn "YSF not implemented"
}

bridge_configure_nxdn() {
    log_warn "NXDN not implemented"
}

bridge_configure_p25() {
    log_warn "P25 not implemented"
}

bridge_configure_m17() {
    log_warn "M17 not implemented"
}

###############################################################################
# Bridge Writers
###############################################################################

bridge_write_mmdvm() {

    log_info "Updating MMDVM_Bridge"

    log_info " TG   : ${TG:-}"
    log_info " Slot : ${SLOT:-}"
}

bridge_write_analog() {

    log_info "Updating Analog_Bridge"
}

bridge_write_dvswitch() {

    log_info "Updating DVSwitch"
}
