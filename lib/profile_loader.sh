profile_load() {
    local profile="$1"

    profile_exists "$profile" || return 1

    unset NAME TYPE MODE TG SLOT ADDRESS PORT PASSWORD ANNOUNCE

    # shellcheck disable=SC1090
    source "${PROFILE_DIR}/${profile}.conf"
}
