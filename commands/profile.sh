#!/usr/bin/env bash

command_profile() {

    local action="${1:-list}"
    shift || true

    case "$action" in

        list)
            profile_list
            ;;

        show)
            [[ $# -eq 1 ]] || {
                echo "Usage: asldvsctl profile show <profile>"
                return 1
            }

            profile_show "$1"
            ;;

        *)
            echo "Usage:"
            echo "  asldvsctl profile list"
            echo "  asldvsctl profile show <profile>"
            return 1
            ;;
    esac
}
