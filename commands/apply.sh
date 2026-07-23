command_apply() {

    [[ $# -eq 1 ]] || {
        echo "Usage: asldvsctl apply <profile>"
        return 1
    }

    local profile="$1"
    PROFILE="$profile"
    profile_load "$profile" || return 1

    profile_validate || return 1

bridge_configure_network || return 1

services_restart_network || return 1

    state_save
}

