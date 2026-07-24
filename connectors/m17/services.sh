#!/usr/bin/env bash
#
###############################################################################
# M17 Service Management
###############################################################################

connector_restart_network()
{
    service_restart_group NETWORK_SERVICES
}

connector_restart_runtime()
{
    service_restart_group RUNTIME_SERVICES
}
