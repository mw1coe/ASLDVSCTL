#!/usr/bin/env bash

PROJECT_ROOT="$(pwd)"

source lib/common.sh
source lib/logging.sh
source lib/system.sh

log_info "OS: $(detect_os)"
log_info "Architecture: $(detect_architecture)"
log_info "Kernel: $(detect_kernel)"
log_info "Hostname: $(detect_hostname)"

if is_debian; then
    log_info "Debian detected."
else
    log_error "Unsupported OS."
fi

if check_internet; then
    log_info "Internet: OK"
else
    log_warn "Internet: Not available"
fi
