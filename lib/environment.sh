#!/usr/bin/env bash
#
###############################################################################
# ASLDVSCTL
# Environment Detection Library
###############################################################################

[[ -n "${ASLDVSCTL_ENVIRONMENT_LOADED:-}" ]] && return
readonly ASLDVSCTL_ENVIRONMENT_LOADED=1

environment_virtualized()
{
    systemd-detect-virt --quiet
}

environment_type()
{
    systemd-detect-virt 2>/dev/null || echo "bare-metal"
}

environment_hostname()
{
    hostname
}

environment_architecture()
{
    uname -m
}

environment_kernel()
{
    uname -r
}
