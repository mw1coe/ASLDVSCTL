#!/usr/bin/env bash
#
###############################################################################
# ASLDVSCTL
# Profile Command
###############################################################################

command_profile()
{
    [[ $# -ge 1 ]] || {
        echo "Usage:"
        echo "  asldvsctl profile list"
        echo "  asldvsctl profile show <profile>"
        echo "  asldvsctl profile apply <profile>"
        echo "  asldvsctl profile validate <profile>"
        return 1
    }

    case "$1" in

        list)
            profile_list
            ;;

        show)
            [[ $# -eq 2 ]] || {
                echo "Usage: asldvsctl profile show <profile>"
                return 1
            }

            profile_show "$2"
            ;;

        apply)
            [[ $# -eq 2 ]] || {
                echo "Usage: asldvsctl profile apply <profile>"
                return 1
            }

            command_apply "$2"
            ;;

        validate)
            [[ $# -eq 2 ]] || {
                echo "Usage: asldvsctl profile validate <profile>"
                return 1
            }

            profile_validate "$2"
            ;;

        create)
            [[ $# -eq 2 ]] || {
                echo "Usage: asldvsctl profile create <profile>"
                return 1
            }

            profile_create "$2"
            ;;

        clone)
            [[ $# -eq 3 ]] || {
                echo "Usage: asldvsctl profile clone <source> <target>"
                return 1
            }

            profile_clone "$2" "$3"
            ;;

        *)
            log_error "Unknown profile command: $1"
            return 1
            ;;
    esac

    return 0
}
