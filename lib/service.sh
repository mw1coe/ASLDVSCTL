#!/usr/bin/env bash
#
###############################################################################
# Service Library
###############################################################################

[[ -n "${ASLDVSCTL_SERVICE_LOADED:-}" ]] && return
readonly ASLDVSCTL_SERVICE_LOADED=1

service_exists()
{
    local service="$1"

    systemctl list-unit-files --type=service \
        | awk '{print $1}' \
        | grep -qx "${service}.service"
}

service_is_active()
{
    local service="$1"

    systemctl is-active --quiet "$service"
}

service_start()
{
    local service="$1"

    log_info "Starting ${service}"

    systemctl start "$service"
}

service_stop()
{
    local service="$1"

    log_info "Stopping ${service}"

    systemctl stop "$service"
}

service_restart()
{
    local service="$1"

    log_info "Restarting ${service}"

    systemctl restart "$service"
}

service_reload()
{
    local service="$1"

    log_info "Reloading ${service}"

    systemctl reload "$service"
}

service_enable()
{
    local service="$1"

    log_info "Enabling ${service}"

    systemctl enable "$service"
}

service_disable()
{
    local service="$1"

    log_info "Disabling ${service}"

    systemctl disable "$service"
}
