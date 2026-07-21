#!/usr/bin/env bash
#
###############################################################################
#
# ASLDVSCTL
# System Detection Library
#
###############################################################################

[[ -n "${ASLDVSCTL_SYSTEM_LOADED:-}" ]] && return
readonly ASLDVSCTL_SYSTEM_LOADED=1

source "${PROJECT_ROOT}/lib/common.sh"
source "${PROJECT_ROOT}/lib/logging.sh"

detect_architecture() {
    uname -m
}

detect_kernel() {
    uname -r
}

detect_hostname() {
    hostname
}

detect_os() {
    if [[ -r /etc/os-release ]]; then
        . /etc/os-release
        printf "%s\n" "${PRETTY_NAME}"
    else
        printf "Unknown\n"
    fi
}

is_debian() {
    [[ -f /etc/debian_version ]]
}

is_root() {
    [[ $EUID -eq 0 ]]
}

check_internet() {
    ping -c1 -W2 1.1.1.1 >/dev/null 2>&1
}

###############################################################################
# Check for Root Privileges
###############################################################################

is_root() {

    if [[ ${EUID} -eq 0 ]]; then
        return 0
    fi

    log_error "This program must be run as root."

    return 1
}

###############################################################################
# Check Debian
###############################################################################

is_debian() {

    if [[ -f /etc/os-release ]]; then

        # shellcheck disable=SC1091
        source /etc/os-release

        [[ "${ID}" == "debian" ]] && return 0

    fi

    log_error "Unsupported operating system."

    return 1
}

###############################################################################
# Get Hostname
###############################################################################

get_hostname() {

    local hostname

    hostname="$(hostname 2>/dev/null)"

    if [[ -n "$hostname" ]]; then
        printf '%s\n' "$hostname"
        return 0
    fi

    log_error "Unable to determine hostname."

    return 1
}

###############################################################################
# Get System Architecture
###############################################################################

get_architecture() {

    local arch

    arch="$(uname -m 2>/dev/null)"

    if [[ -n "$arch" ]]; then
        printf '%s\n' "$arch"
        return 0
    fi

    log_error "Unable to determine system architecture."

    return 1
}

###############################################################################
# Get Kernel Version
###############################################################################

get_kernel() {

    local kernel

    kernel="$(uname -r 2>/dev/null)"

    if [[ -n "$kernel" ]]; then
        printf '%s\n' "$kernel"
        return 0
    fi

    log_error "Unable to determine kernel version."

    return 1
}

###############################################################################
# Get Primary IP Address
###############################################################################

get_ip_address() {

    local ip

    ip="$(ip -4 route get 1.1.1.1 2>/dev/null | awk '/src/ {print $7; exit}')"

    if [[ -n "$ip" ]]; then
        printf '%s\n' "$ip"
        return 0
    fi

    log_error "Unable to determine IP address."

    return 1
}

###############################################################################
# Check Internet Connectivity
###############################################################################

check_internet() {

    if ping -c 1 -W 2 1.1.1.1 >/dev/null 2>&1; then
        log_info "Internet connectivity verified."
        return 0
    fi

    log_error "No Internet connectivity."

    return 1
}

###############################################################################
# Check System Requirements
###############################################################################

check_system_requirements() {

    log_info "Checking system requirements..."

    is_root || return 1
    is_debian || return 1

    local hostname
    local arch
    local kernel
    local ip

    hostname="$(get_hostname)" || return 1
    arch="$(get_architecture)" || return 1
    kernel="$(get_kernel)" || return 1
    ip="$(get_ip_address)" || return 1

    check_internet || return 1

    log_info "Hostname     : ${hostname}"
    log_info "Architecture : ${arch}"
    log_info "Kernel       : ${kernel}"
    log_info "IP Address   : ${ip}"

    log_info "System requirements satisfied."

    return 0
}

