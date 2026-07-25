#!/usr/bin/env bash
#
# ASLDVSCTL
# Logs Command
#

command_logs()
{
    [[ $# -le 1 ]] || {
        echo "Usage: asldvsctl logs [service]"
        return 1
    }

    local service="${1:-all}"

    case "$service" in
        all)
            journalctl -n 100
            ;;

        mmdvm)
            journalctl -u mmdvm_bridge -n 100
            ;;

        analog)
            journalctl -u analog_bridge -n 100
            ;;

        md380)
            journalctl -u md380-emu -n 100
            ;;

        asterisk)
            journalctl -u asterisk -n 100
            ;;

        *)
            echo "Unknown service: $service"
            return 1
            ;;
    esac

    return 0
}
