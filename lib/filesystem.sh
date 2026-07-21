#!/usr/bin/env bash
#
###############################################################################
# Filesystem Library
###############################################################################

[[ -n "${ASLDVSCTL_FILESYSTEM_LOADED:-}" ]] && return
readonly ASLDVSCTL_FILESYSTEM_LOADED=1

source "${PROJECT_ROOT}/lib/common.sh"
source "${PROJECT_ROOT}/lib/logging.sh"

###############################################################################
# Create Directory
###############################################################################

create_directory() {

    local dir="$1"

    if [[ -z "$dir" ]]; then
        log_error "create_directory(): missing directory name"
        return 1
    fi

    if [[ ! -d "$dir" ]]; then
        mkdir -p "$dir" || {
            log_error "Failed to create directory: $dir"
            return 1
        }
        log_info "Created directory: $dir"
    fi

    return 0
}

###############################################################################
# File Exists
###############################################################################

file_exists() {

    local file="$1"

    [[ -n "$file" ]] || return 1

    [[ -f "$file" ]]

}

###############################################################################
# Directory Exists
###############################################################################

directory_exists() {

    local dir="$1"

    [[ -n "$dir" ]] || return 1

    [[ -d "$dir" ]]

}

###############################################################################
# Copy File
###############################################################################

copy_file() {

    local src="$1"
    local dst="$2"

    if [[ -z "$src" || -z "$dst" ]]; then
        log_error "copy_file(): source and destination required"
        return 1
    fi

    if ! file_exists "$src"; then
        log_error "Source file not found: $src"
        return 1
    fi

    local dst_dir
    dst_dir="$(dirname "$dst")"

    create_directory "$dst_dir"

    if cp -a "$src" "$dst"; then
        log_info "Copied: $src -> $dst"
        return 0
    fi

    log_error "Failed to copy: $src -> $dst"
    return 1
}

###############################################################################
# Copy Directory
###############################################################################

copy_directory() {

    local src="$1"
    local dst="$2"

    if [[ -z "$src" || -z "$dst" ]]; then
        log_error "copy_directory(): source and destination required"
        return 1
    fi

    if ! directory_exists "$src"; then
        log_error "Source directory not found: $src"
        return 1
    fi

    create_directory "$dst"

    if cp -a "${src}/." "$dst"; then
        log_info "Copied directory: $src -> $dst"
        return 0
    fi

    log_error "Failed to copy directory: $src -> $dst"
    return 1
}

###############################################################################
# Backup File
###############################################################################

backup_file() {

    local file="$1"

    if [[ -z "$file" ]]; then
        log_error "backup_file(): missing filename"
        return 1
    fi

    if ! file_exists "$file"; then
        log_warn "Backup skipped (file not found): $file"
        return 0
    fi

    create_directory "$BACKUP_DIR"

    local backup
    backup="${BACKUP_DIR}/$(basename "$file").$(date +%Y%m%d-%H%M%S)"

    if cp -a "$file" "$backup"; then
        log_info "Backup created: $backup"
        return 0
    fi

    log_error "Failed to backup: $file"
    return 1
}

###############################################################################
# Remove File
###############################################################################

remove_file() {

    local file="$1"

    if [[ -z "$file" ]]; then
        log_error "remove_file(): missing filename"
        return 1
    fi

    if ! file_exists "$file"; then
        log_warn "File not found: $file"
        return 0
    fi

    if rm -f "$file"; then
        log_info "Removed file: $file"
        return 0
    fi

    log_error "Failed to remove file: $file"
    return 1
}

###############################################################################
# Remove Directory
###############################################################################

remove_directory() {

    local dir="$1"

    if [[ -z "$dir" ]]; then
        log_error "remove_directory(): missing directory name"
        return 1
    fi

    if ! directory_exists "$dir"; then
        log_warn "Directory not found: $dir"
        return 0
    fi

    if rm -rf "$dir"; then
        log_info "Removed directory: $dir"
        return 0
    fi

    log_error "Failed to remove directory: $dir"
    return 1
}

###############################################################################
# Set Permissions
###############################################################################

set_permissions() {

    local mode="$1"
    local target="$2"

    if [[ -z "$mode" || -z "$target" ]]; then
        log_error "set_permissions(): mode and target required"
        return 1
    fi

    if [[ ! -e "$target" ]]; then
        log_error "Target does not exist: $target"
        return 1
    fi

    if chmod "$mode" "$target"; then
        log_info "Permissions set to $mode: $target"
        return 0
    fi

    log_error "Failed to set permissions on: $target"
    return 1
}

###############################################################################
# Set Owner
###############################################################################

set_owner() {

    local owner="$1"
    local target="$2"

    if [[ -z "$owner" || -z "$target" ]]; then
        log_error "set_owner(): owner and target required"
        return 1
    fi

    if [[ ! -e "$target" ]]; then
        log_error "Target does not exist: $target"
        return 1
    fi

    if chown "$owner" "$target"; then
        log_info "Owner set to $owner: $target"
        return 0
    fi

    log_error "Failed to set owner on: $target"
    return 1
}
