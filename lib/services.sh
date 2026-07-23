#!/usr/bin/env bash
#
# ASLDVSCTL 2.0
# Service Management Library
#

[[ -n "${ASLDVSCTL_SERVICES_LOADED:-}" ]] && return
readonly ASLDVSCTL_SERVICES_LOADED=1

###############################################################################
# Start
###############################################################################

service_start() {

    local service="$1"

    log_info "Starting ${service}"

    sudo systemctl start "${service}"
}

###############################################################################
# Stop
###############################################################################

service_stop() {

    local service="$1"

    log_info "Stopping ${service}"

    sudo systemctl stop "${service}"
}

###############################################################################
# Restart
###############################################################################

service_restart() {

    local service="$1"

    log_info "Restarting ${service}"

    sudo systemctl restart "${service}"
}

###############################################################################
# Status
###############################################################################

service_restart()
{
    local service="$1"

    [[ -n "$service" ]] || {
        log_error "No service specified"
        return 1
    }

    log_info "Restarting ${service}"

    if ! systemctl restart "$service"; then
        log_error "Failed to restart ${service}"
        return 1
    fi

    if systemctl is-active --quiet "$service"; then
        log_info "${service} is running"
        return 0
    else
        log_error "${service} failed to start"
        return 1
    fi
}

###############################################################################
# Restart Runtime Services
###############################################################################

services_restart_runtime()
{
    service_restart analog_bridge
    service_restart mmdvm_bridge
}

###############################################################################
# Restart Network Services
###############################################################################

services_restart_network()
{
    service_restart md380-emu
    service_restart mmdvm_bridge
    service_restart analog_bridge
}

###############################################################################
# Running?
###############################################################################

service_running() {

    local service="$1"

    systemctl is-active --quiet "${service}"
}
