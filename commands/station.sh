#!/usr/bin/env bash
#
# ASLDVSCTL
# Station Command
#

command_station()
{

    [[ $# -ge 1 ]] || {
        echo "Usage:"
        echo "  asldvsctl station show"
        echo "  asldvsctl station set <field> <value>"
        return 1
    }

    case "$1" in
        show)
            station_summary
            ;;

        set)
            [[ $# -eq 3 ]] || {
                echo "Usage: asldvsctl station set <field> <value>"
                return 1
            }

            station_set "$2" "$3"
            ;;

        validate)
            station_validate
            ;;

        *)
            echo "Unknown station command: $1"
            return 1
            ;;
    esac

    return 0
}

