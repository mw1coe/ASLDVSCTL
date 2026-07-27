#!/usr/bin/env bash
#
###############################################################################
# Runtime Command
###############################################################################

command_runtime()
{
    [[ $# -ge 1 ]] || {
        echo "Usage:"
        echo "  asldvsctl runtime show"
        echo "  asldvsctl runtime save"
        echo "  asldvsctl runtime load"
        echo "  asldvsctl runtime reset"
        echo "  asldvsctl runtime validate"
        return 1
    }

    case "$1" in

        show)
            runtime_show
            ;;

        save)
            runtime_save
            ;;

        load)
            runtime_load
            ;;

        reset)
            runtime_reset
            ;;

        validate)
            runtime_validate
            ;;

        *)
            log_error "Unknown runtime command: $1"
            return 1
            ;;

    esac

    return 0
}
