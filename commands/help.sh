#!/usr/bin/env bash

command_help() {
cat <<EOF
ASLDVSCTL ${ASLDVSCTL_VERSION:-2.0.0}

Usage:
    asldvsctl <command> [options]

Commands
    help        Show this help
    version     Show version
    status      Show system status
    check       Verify installation
    install     Install ASLDVSCTL
    apply       Apply profile
    mode        Change mode
    tg          Change talkgroup
    backup      Backup configuration
EOF
}
