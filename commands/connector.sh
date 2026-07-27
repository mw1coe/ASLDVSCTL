#!/usr/bin/env bash
#
###############################################################################
# CONNECTOR
###############################################################################

command_connector()
{
    [[ $# -ge 1 ]] || {
        echo "Usage:"
        echo "  asldvsctl connector list"
        echo "  asldvsctl connector show <connector>"
        echo "  asldvsctl connector status <connector>"
        echo "  asldvsctl connector validate <connector>"
        return 1
    }

    case "$1" in
        list)
            connector_list
            ;;

        show)
            [[ $# -eq 2 ]] || {
                echo "Usage: asldvsctl connector show <connector>"
                return 1
            }

            connector_load "$2" || return 1
            connector_show
            ;;

        status)
            connector_load "$2" || return 1
            connector_status
            ;;

            validate)
            connector_load "$2" || return 1
            connector_validate
            ;;

            current)
            connector_current
            ;;

            install)
            [[ $# -eq 2 ]] || {
                echo "Usage: asldvsctl connector install <connector>"
                return 1
            }

            connector_load "$2" || return 1
            connector_install
            ;;

        *)
            log_error "Unknown connector command: $1"
            return 1
            ;;

        uninstall)
            [[ $# -eq 2 ]] || {
                echo "Usage: asldvsctl connector uninstall <connector>"
                return 1
            }

            connector_load "$2" || return 1
            connector_uninstall
            ;;

    esac

    return 0
}

