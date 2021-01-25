#!/bin/bash
log_setup() {
    case $1 in 
    clear_logs)
    :
    ;;
    first_init)
    :
    ;;
    init)
    file_time="$(datxe +"%D %T")"
    ;;
    *)
    :
    ;;
}