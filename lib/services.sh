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

service_restart()
{
    local service="$1"

    [[ -n "$service" ]] || {
        log_error "No service specified"
        return 1
    }

###################################################>
# Status
###################################################>

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
    local svc

    for svc in ${RUNTIME_SERVICES:-}; do
        service_restart "$svc" || return 1
    done
}

###############################################################################
# Restart Network Services
###############################################################################

services_restart_network()
{
    local svc

    for svc in ${NETWORK_SERVICES:-}; do
        service_restart "$svc" || return 1
    done
}

###############################################################################
# Running?
###############################################################################

service_running() {

    local service="$1"

    systemctl is-active --quiet "${service}"
}
