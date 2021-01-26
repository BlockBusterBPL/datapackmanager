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
    unformatted_time="$(date +"%D %T")"
    file_time="$()"
    cd "$DPM_DIR"
    cd logs
    touch "${file_time}.txt"
    ;;
    *)
    :
    ;;
    esac
}