#!/usr/bin/env bash
#
###############################################################################
#
# ASLDVSCTL
# Logging Library
#
###############################################################################

# Prevent multiple inclusion
[[ -n "${ASLDVSCTL_LOGGING_LOADED:-}" ]] && return
readonly ASLDVSCTL_LOGGING_LOADED=1

# Load common library
source "${PROJECT_ROOT}/lib/common.sh"

timestamp() {
    date '+%Y-%m-%d %H:%M:%S'
}

log_info() {
    printf "[%s] [INFO ] %s\n"  "$(timestamp)" "$*"
}

log_warn() {
    printf "[%s] [WARN ] %s\n"  "$(timestamp)" "$*"
}

log_error() {
    printf "[%s] [ERROR] %s\n" "$(timestamp)" "$*" >&2
}

log_debug() {
    [[ "${DEBUG:-0}" == "1" ]] || return 0
    printf "[%s] [DEBUG] %s\n" "$(timestamp)" "$*"
}
