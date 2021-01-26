#!/bin/bash
log_setup() {
    case $1 in 
    clear_logs)
    cd "$DPM_DIR/logs"
    rm *.txt
    ;;
    first_init)
    cd "$DPM_DIR"
    mkdir logs
    ;;
    init)
    unformatted_time="$(date +"%D %T")"
    file_time="$(echo "$unformatted_time" | tr '/' '.' | tr ':' '.')"
    cd "$DPM_DIR/logs"
    touch "${file_time}.txt"
    log_name="${LOG_DIR}/${file_time}.txt"
    cd ..
    cd extensions
    ;;
    *)
    :
    ;;
    esac
}