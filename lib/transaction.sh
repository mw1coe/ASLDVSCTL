#!/usr/bin/env bash
#
# ASLDVSCTL
# Transaction Library
#

[[ -n "${ASLDVSCTL_TRANSACTION_LOADED:-}" ]] && return
readonly ASLDVSCTL_TRANSACTION_LOADED=1

###############################################################################
# Transaction State
###############################################################################

TRANSACTION_ID=""
TRANSACTION_DIR=""

###############################################################################
# Begin Transaction
###############################################################################

transaction_begin()
{
    TRANSACTION_FILES=0
    TRANSACTION_ID="$(date +%Y%m%d-%H%M%S)"
    TRANSACTION_DIR="${BACKUP_DIR}/transactions/${TRANSACTION_ID}"

    mkdir -p "${TRANSACTION_DIR}" || return 1

    log_info "Beginning transaction ${TRANSACTION_ID}"
}

###############################################################################
# Backup File
###############################################################################

transaction_backup()
{
    local file="$1"
    local relative

    [[ -n "$TRANSACTION_DIR" ]] || {
        log_error "Transaction not started"
        return 1
    }

    [[ -f "$file" ]] || return 0

    relative="${file#/}"

    mkdir -p "${TRANSACTION_DIR}/$(dirname "$relative")" || return 1

    cp -a "$file" "${TRANSACTION_DIR}/${relative}" || return 1

    ((TRANSACTION_FILES**))    

log_info "Backup: ${file}"
}

###############################################################################
# Rollback
###############################################################################

transaction_rollback()
{
    local file
    local target

    [[ -d "$TRANSACTION_DIR" ]] || {
        TRANSACTION_DIR="$(transaction_latest)"
    }

    [[ -d "$TRANSACTION_DIR" ]] || {
        log_error "No transaction available."
        return 1
    }

    log_warn "Rolling back transaction..."

    while IFS= read -r file
    do
        target="/${file#${TRANSACTION_DIR}/}"

        mkdir -p "$(dirname "$target")"

        cp -a "$file" "$target" || {
            log_error "Failed restoring ${target}"
            return 1
        }

        log_info "Restored ${target}"

    done < <(find "$TRANSACTION_DIR" -type f)

    log_info "Rollback complete"

    return 0
}

###############################################################################
# Commit
###############################################################################

transaction_commit()
{
    [[ -d "$TRANSACTION_DIR" ]] || return 0

    rm -rf "$TRANSACTION_DIR"

    log_info "Transaction committed"

    TRANSACTION_ID=""
    TRANSACTION_DIR=""
}

###############################################################################
# Abort
###############################################################################

transaction_abort()
{
    transaction_rollback
    transaction_commit
}

###############################################################################
# Status
###############################################################################

transaction_active()
{
    [[ -n "$TRANSACTION_DIR" ]]
}

###############################################################################
# Show
###############################################################################

transaction_show()
{
    echo "Transaction"
    echo "-----------"

    if transaction_active
    then
        printf "ID        : %s\n" "$TRANSACTION_ID"
        printf "Files     : %s\n" "$TRANSACTION_FILES"
        printf "Directory : %s\n" "$TRANSACTION_DIR"
    else
        echo "No active transaction."
    fi

    echo
}

###############################################################################
# Backup Multiple Files
###############################################################################

transaction_backup_list()
{
    local file

    for file in "$@"
    do
        transaction_backup "$file" || return 1
    done
}

###############################################################################
# Backup Connector Files
###############################################################################

transaction_backup_connector()
{
    local file

    while IFS= read -r file
    do
        [[ -n "$file" ]] || continue
        transaction_backup "$file" || return 1
    done < <(connector_transaction_files)
}

###############################################################################
# Latest Transaction
###############################################################################

transaction_latest()
{
    find "${BACKUP_DIR}/transactions" \
        -mindepth 1 \
        -maxdepth 1 \
        -type d \
        | sort \
        | tail -1
}
