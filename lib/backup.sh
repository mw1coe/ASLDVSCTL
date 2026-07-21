backup_configs() {

    local ts

    ts=$(date +%Y%m%d-%H%M%S)

    mkdir -p "${BACKUP_DIR}/${ts}"

    cp /opt/MMDVM_Bridge/MMDVM_Bridge.ini \
       "${BACKUP_DIR}/${ts}/"

    cp /opt/Analog_Bridge/Analog_Bridge.ini \
       "${BACKUP_DIR}/${ts}/"

    log_info "Backup created: ${ts}"
}
