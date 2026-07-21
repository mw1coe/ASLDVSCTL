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

service_status() {

    local service="$1"

    systemctl is-active "${service}"
}

###############################################################################
# Running?
###############################################################################

service_running() {

    local service="$1"

    systemctl is-active --quiet "${service}"
}
