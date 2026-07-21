command_apply() {

    [[ $# -eq 1 ]] || {
        echo "Usage: asldvsctl apply <profile>"
        return 1
    }

    local profile="$1"
    PROFILE="$profile"
    profile_load "$profile" || return 1

    profile_validate || return 1

    echo "Applying profile $profile"
    echo "Name : ${NAME:-}"
    echo "Mode : ${MODE:-}"

    bridge_configure

    state_save
}

