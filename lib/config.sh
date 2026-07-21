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

load_config() {
    if [[ -f "${USER_CONFIG}" ]]; then
        # shellcheck disable=SC1090
        source "${USER_CONFIG}"
        log_info "Loaded ${USER_CONFIG}"
    else
        # shellcheck disable=SC1090
        source "${DEFAULT_CONFIG}"
        log_warn "Using default configuration"
    fi
}

save_config() {

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
