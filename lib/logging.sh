#!/usr/bin/env bash
#
###############################################################################
# ASLDVSCTL Logging Library
###############################################################################

# Default log level
: "${LOG_LEVEL:=INFO}"

log_timestamp()
{
    date '+%Y-%m-%d %H:%M:%S'
}

log_debug()
{
    [[ "${LOG_LEVEL}" == "DEBUG" ]] || return 0
    printf "[%s] DEBUG: %s\n" "$(log_timestamp)" "$*"
}

log_info()
{
    printf "[%s] INFO : %s\n" "$(log_timestamp)" "$*"
}

log_warn()
{
    printf "[%s] WARN : %s\n" "$(log_timestamp)" "$*" >&2
}

log_error()
{
    printf "[%s] ERROR: %s\n" "$(log_timestamp)" "$*" >&2
}
