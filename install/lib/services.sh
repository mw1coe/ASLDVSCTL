#!/usr/bin/env bash
#
# Service Management Library
#

[[ -n "${ASLDVSCTL_INSTALL_SERVICES_LOADED:-}" ]] && return
readonly ASLDVSCTL_INSTALL_SERVICES_LOADED=1

service_manage()
{
    local service="$1"

    if ! systemctl list-unit-files | grep -q "^${service}\.service"
    then
        printf "  [SKIP] %-20s (not installed)\n" "$service"
        return 0
    fi

    printf "  [INFO] %-20s\n" "$service"

    systemctl enable "${service}" >/dev/null 2>&1 || true
    systemctl restart "${service}"

    if systemctl is-active --quiet "${service}"
    then
        printf "  [PASS] %-20s running\n" "$service"
    else
        printf "  [FAIL] %-20s failed\n" "$service"
        return 1
    fi
}
