#!/usr/bin/env bash
#
# ASLDVSCTL
# Project Library
#

[[ -n "${ASLDVSCTL_PROJECT_LOADED:-}" ]] && return
readonly ASLDVSCTL_PROJECT_LOADED=1

project_summary()
{
    printf "Project\n"
    printf "%s\n" "-------"

    printf "Root       : %s\n" "${PROJECT_ROOT}"
    printf "Version    : %s\n" "${ASLDVSCTL_VERSION}"

    echo
}

project_version()
{
    printf "%s\n" "${ASLDVSCTL_VERSION}"
}

project_root()
{
    printf "%s\n" "${PROJECT_ROOT}"
}
