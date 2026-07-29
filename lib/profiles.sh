#!/usr/bin/env bash
#
###############################################################################
# ASLDVSCTL
# Profile Management Library
###############################################################################

[[ -n "${ASLDVSCTL_PROFILES_LOADED:-}" ]] && return
readonly ASLDVSCTL_PROFILES_LOADED=1

profile_exists() {
    [[ -f "${PROFILE_DIR}/$1.conf" ]]
}

profile_list() {
    for file in "${PROFILE_DIR}"/*.conf; do
        [[ -e "$file" ]] || continue
        basename "$file" .conf
    done | sort -V
}

profile_show()
{
    local profile="$1"

    profile_load "$profile" || return 1

    printf "Profile\n"
    printf "%s\n" "-------"

    printf "ID          : %s\n" "$profile"
    printf "Name        : %s\n" "${NAME:-Unknown}"
    printf "Description : %s\n" "${DESCRIPTION:-None}"

    printf "\nRuntime\n"
    printf "%s\n" "-------"

    printf "Mode        : %s\n" "${MODE:-Unknown}"
    printf "Connector   : %s\n" "${CONNECTOR:-Unknown}"

    printf "\nNetwork\n"
    printf "%s\n" "-------"

    printf "Address     : %s\n" "${ADDRESS:-None}"
    printf "Port        : %s\n" "${PORT:-None}"

    printf "\nDefaults\n"
    printf "%s\n" "--------"

    printf "Talkgroup   : %s\n" "${DEFAULT_TG:-None}"
    printf "Slot        : %s\n" "${DEFAULT_SLOT:-None}"

    printf "\nAudio\n"
    printf "%s\n" "-----"

    printf "Announce    : %s\n" "${ANNOUNCE:-None}"

    return 0
}

profile_load() {
    local profile="$1"

    profile_exists "$profile" || {
        log_error "Profile '$profile' not found."
        declare -p NAME TYPE ADDRESS PORT PASSWORD 2>/dev/null
        return 1
    }

    # Clear previous values
 
unset \
    NAME \
    DESCRIPTION \
    TYPE \
    MODE \
    CONNECTOR \
    TG \
    SLOT \
    DEFAULT_TG \
    DEFAULT_SLOT \
    ADDRESS \
    PORT \
    PASSWORD \
    ANNOUNCE \
    OPTIONS


    # shellcheck source=/dev/null
    source "${PROFILE_DIR}/${profile}.conf"

   ###############################################################################
   # Legacy Compatibility
   ###############################################################################

if [[ -z "${MODE:-}" && -n "${TYPE:-}" ]]; then
    MODE="${TYPE}"
fi

    ###########################################################################
    # Connector Compatibility
    ###########################################################################

    if [[ -z "${CONNECTOR:-}" ]]; then

        case "${MODE:-}" in

            DMR)
                CONNECTOR="mmdvm"
                ;;

            YSF)
                CONNECTOR="ysf"
                ;;

            NXDN)
                CONNECTOR="nxdn"
                ;;

            P25)
                CONNECTOR="p25"
                ;;

            M17)
                CONNECTOR="m17"
                ;;

        esac

    fi


    ###########################################################################
    # Load Connector
    ###########################################################################

[[ -n "${CONNECTOR:-}" ]] || {
    log_error "No connector specified for profile '$profile'"
    return 1
}

connector_load "${CONNECTOR}" || {
    log_error "Unable to load connector '$CONNECTOR'"
    return 1
}

    export \
        PROFILE \
        NAME \
        DESCRIPTION \
        MODE \
        CONNECTOR \
        DEFAULT_TG \
        DEFAULT_SLOT \
        ADDRESS \
        PORT \
        PASSWORD \
        ANNOUNCE \
        OPTIONS

    return 0
}

###############################################################################
# Legacy Compatibility
###############################################################################

profile_validate() {
    local ok=1

    [[ -n "${NAME:-}" ]] || {
        log_error "Missing NAME"
        ok=0
    }

    [[ -n "${MODE:-}" ]] || {
        log_error "Missing MODE"
        ok=0
    }

    case "${MODE:-}" in
DMR)
    [[ -n "${ADDRESS:-}" ]] || {
        log_error "Missing ADDRESS"
        ok=0
    }

    [[ -n "${PORT:-}" ]] || {
        log_error "Missing PORT"
        ok=0
    }

    ;;

        YSF|NXDN|P25|M17)
            ;;
        *)
            log_error "Unsupported MODE '${MODE:-}'"
            ok=0
            ;;
    esac

    (( ok )) || return 1
}
