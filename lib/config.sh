#!/usr/bin/env bash
#
###############################################################################
# Configuration Library
###############################################################################

[[ -n "${ASLDVSCTL_CONFIG_LOADED:-}" ]] && return
readonly ASLDVSCTL_CONFIG_LOADED=1

source "${PROJECT_ROOT}/lib/common.sh"
source "${PROJECT_ROOT}/lib/logging.sh"

readonly DEFAULT_CONFIG="${PROJECT_ROOT}/config/default.conf"
readonly USER_CONFIG="/etc/asldvsctl.conf"

load_config()
{
    if [[ -f "${USER_CONFIG}" ]]; then
        # shellcheck disable=SC1090
        source "${USER_CONFIG}"
        CONFIG_SOURCE="user"
    else
        # shellcheck disable=SC1090
        source "${DEFAULT_CONFIG}"
        CONFIG_SOURCE="default"
    fi

    return 0
}

save_config()

{
    [[ -w "$(dirname "$USER_CONFIG")" ]] || {
        log_error "Root privileges are required to update ${USER_CONFIG}."
        return 1
    }

cat > "${USER_CONFIG}" <<EOF
CALLSIGN=${CALLSIGN}
NODE=${NODE}
DMR_ID=${DMR_ID}

ASL_PASSWORD=${ASL_PASSWORD}
BM_PASSWORD=${BM_PASSWORD}
TGIF_PASSWORD=${TGIF_PASSWORD}

DEFAULT_MODE=${DEFAULT_MODE}
DEFAULT_TG=${DEFAULT_TG}
DEFAULT_SLOT=${DEFAULT_SLOT}

USRP_HOST=${USRP_HOST}
USRP_PORT=${USRP_PORT}
USRP_NODE=${USRP_NODE}

LOG_LEVEL=${LOG_LEVEL}
EOF

}

###############################################################################
# Get Configuration Value
###############################################################################

config_set()
{
    local key="$1"
    local value="$2"

    case "$key" in
        CALLSIGN|NODE|DMR_ID|ASL_PASSWORD|BM_PASSWORD|TGIF_PASSWORD|\
        DEFAULT_MODE|DEFAULT_TG|DEFAULT_SLOT|\
        USRP_HOST|USRP_PORT|USRP_NODE|LOG_LEVEL)
            ;;
        *)
            log_error "Unknown configuration key: $key"
            return 1
            ;;
    esac

    config_validate "$key" "$value" || {
        log_error "Invalid value for ${key}"
        return 1
    }

    printf -v "$key" '%s' "$value"

    save_config || return 1

    return 0
}

###############################################################################
# Configuration Exists?
###############################################################################

config_exists()
{
    local key="$1"

    [[ -v "$key" ]]
}

###############################################################################
# Validate Configuration Value
###############################################################################

config_validate()
{
    local key="$1"
    local value="$2"

    case "$key" in

        CALLSIGN)
            [[ "$value" =~ ^[A-Za-z0-9/-]+$ ]] || return 1
            ;;

        NODE)
            [[ "$value" =~ ^[0-9]+$ ]] || return 1
            ;;

        DMR_ID)
            [[ "$value" =~ ^[0-9]{6,9}$ ]] || return 1
            ;;

        DEFAULT_TG)
            [[ "$value" =~ ^[0-9]+$ ]] || return 1
            ;;

        DEFAULT_SLOT)
            [[ "$value" =~ ^[12]$ ]] || return 1
            ;;

        USRP_PORT)
            [[ "$value" =~ ^[0-9]+$ ]] || return 1
            ;;

        USRP_NODE)
            [[ "$value" =~ ^[0-9]+$ ]] || return 1
            ;;

        *)
            return 0
            ;;
    esac

    return 0
}


