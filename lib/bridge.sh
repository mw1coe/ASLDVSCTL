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

bridge_configure_network()
{
    connector_load "$CONNECTOR" || return 1
    connector_generate_network
}

bridge_configure_runtime()
{
    connector_load "$CONNECTOR" || return 1
    connector_generate_runtime
}
