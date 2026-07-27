#!/usr/bin/env bash

command_service()
{
    [[ $# -ge 1 ]] || {
        command_service_help
        return 1
    }

    case "$1" in

        status)
            service_status
            ;;

        restart)
            service_restart "$2"
            ;;

        start)
            service_start "$2"
            ;;

        stop)
            service_stop "$2"
            ;;

        reload)
            service_reload "$2"
            ;;

        enable)
            service_enable "$2"
            ;;

        disable)
            service_disable "$2"
            ;;

        *)
            command_service_help
            return 1
            ;;
    esac
}

command_service_help()
{
cat <<EOF
Usage:

asldvsctl service status

asldvsctl service restart <service>

asldvsctl service start <service>

asldvsctl service stop <service>

asldvsctl service reload <service>

asldvsctl service enable <service>

asldvsctl service disable <service>
EOF
}


