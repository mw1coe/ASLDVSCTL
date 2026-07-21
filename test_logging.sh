#!/usr/bin/env bash

PROJECT_ROOT="$(pwd)"

source lib/common.sh
source lib/logging.sh

log_info "Starting test"
log_warn "This is a warning"
log_error "This is an error"

DEBUG=1
log_debug "Debug output enabled"
