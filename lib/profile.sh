#!/usr/bin/env bash
#
###############################################################################
# ASLDVSCTL
# Profile Library
###############################################################################

[[ -n "${ASLDVSCTL_PROFILE_LOADED:-}" ]] && return
readonly ASLDVSCTL_PROFILE_LOADED=1

PROFILE_PATH="${BASE_DIR}/profiles"

profile_exists()
{
    [[ -f "${PROFILE_PATH}/$1.conf" ]]
}

profile_list()
{
    local file

    printf "Profiles\n"
    printf "%s\n" "--------"

    for file in "${PROFILE_PATH}"/*.conf
    do
        [[ -f "$file" ]] || continue
        basename "$file" .conf
    done
}

profile_show()
{
    local profile="$1"

    profile_exists "$profile" || {
        log_error "Unknown profile: ${profile}"
        return 1
    }

    printf "Profile\n"
    printf "%s\n" "-------"

    cat "${PROFILE_PATH}/${profile}.conf"
}

profile_validate()
{
    local profile="$1"

    profile_exists "$profile" || {
        log_error "Unknown profile: ${profile}"
        return 1
    }

    printf "Profile Validation\n"
    printf "%s\n" "------------------"

    printf "PASS  Profile exists\n"

    return 0
}

profile_create()
{
    local profile="$1"
    local file="${PROFILE_PATH}/${profile}.conf"

    profile_exists "$profile" && {
        log_error "Profile ${profile} already exists."
        return 1
    }

    cat > "$file" <<EOF
NAME=New Profile
TYPE=DMR
ADDRESS=
PORT=62031
PASSWORD=
ANNOUNCE=
EOF

    log_info "Created profile ${profile}"

    return 0
}

profile_clone()
{
    local source="$1"
    local target="$2"

    profile_exists "$source" || {
        log_error "Unknown profile: ${source}"
        return 1
    }

    profile_exists "$target" && {
        log_error "Profile ${target} already exists."
        return 1
    }

    cp "${PROFILE_PATH}/${source}.conf" \
       "${PROFILE_PATH}/${target}.conf" || {
        log_error "Failed to clone profile."
        return 1
    }

    log_info "Cloned profile ${source} -> ${target}"

    return 0
}
