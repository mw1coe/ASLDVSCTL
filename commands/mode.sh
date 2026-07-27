#!/usr/bin/env bash
#
###############################################################################
# ASLDVSCTL
# Mode Command
###############################################################################

command_mode()
{
    [[ $# -ge 1 ]] || {
        echo "Usage:"
        echo "  asldvsctl mode list"
        echo "  asldvsctl mode show"
        echo "  asldvsctl mode set <mode>"
        echo "  asldvsctl mode validate"
        return 1
    }

    case "$1" in

        list)
            mode_list
            ;;

        show)
            mode_show
            ;;

        set)
            [[ $# -eq 2 ]] || {
                echo "Usage: asldvsctl mode set <mode>"
                return 1
            }

            mode_set "$2"
            ;;

        validate)
            mode_validate
            ;;

        *)
            log_error "Unknown mode command: $1"
            return 1
            ;;

    esac

    return 0
}

mode_exists()
{
    case "${1^^}" in
        DMR|M17|YSF|P25|NXDN)
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

mode_validate()
{
    state_load >/dev/null 2>&1 || true

    printf "Mode Validation\n"
    printf "%s\n" "---------------"

    if mode_exists "${MODE:-}"; then
        printf "PASS  Mode\n"
    else
        printf "FAIL  Mode\n"
    fi

    return 0
}
