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

bridge_configure()
{
    [[ -n "${CONNECTOR:-}" ]] || {
        log_error "CONNECTOR not defined"
        return 1
    }

    connector_load "${CONNECTOR}" || {
        log_error "Unable to load connector '${CONNECTOR}'"
        return 1
    }

    connector_generate
}

