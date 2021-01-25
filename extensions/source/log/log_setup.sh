#!/bin/bash
log_setup() {
    case $1 in 
    clear_logs)
    :
    ;;
    first_init)
    cd "$DPM_DIR"
    mkdir logs
    ;;
    init)
    file_time="$(date +"%D %T")"
    file_time="$(date +"%D %T")"
    cd "$DPM_DIR"
    cd logs
    touch "${file_time}.txt"
    ;;
    *)
    :
    ;;
    esac
}