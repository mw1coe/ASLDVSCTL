#!/usr/bin/env bash

profile_exists() {
    [[ -f "${PROFILE_DIR}/$1.conf" ]]
}

profile_list() {
    for file in "${PROFILE_DIR}"/*.conf; do
        [[ -e "$file" ]] || continue
        basename "$file" .conf
    done | sort -V
}

profile_show() {
    local profile="$1"

    if profile_exists "$profile"; then
        cat "${PROFILE_DIR}/${profile}.conf"
    else
        log_error "Profile '$profile' not found."
        return 1
    fi
}

profile_load() {
    local profile="$1"

    profile_exists "$profile" || {
        log_error "Profile '$profile' not found."
        declare -p NAME TYPE ADDRESS PORT PASSWORD 2>/dev/null
        return 1
    }

    # Clear previous values
    unset NAME TYPE MODE TG SLOT ADDRESS PORT PASSWORD ANNOUNCE OPTIONS

    # shellcheck source=/dev/null
    source "${PROFILE_DIR}/${profile}.conf"
}

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
            [[ -n "${TG:-}" ]] || {
                log_error "Missing TG"
                ok=0
            }

            [[ -n "${SLOT:-}" ]] || {
                log_error "Missing SLOT"
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
