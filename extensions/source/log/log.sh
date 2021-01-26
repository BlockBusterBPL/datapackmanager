#!/bin/bash
log() {
    log_time=$(date +"%T")
    case $1 in 
        N)
            echo "[$log_time] [INFO]: $2" >> "$log_name"
        ;;
        W)
            echo "[$log_time] [WARN]: $2" >> "$log_name"
        ;;
        E)
            echo "[$log_time] [ERROR]: $2" >> "$log_name"
        ;;
        *)
            echo "[$log_time] [ERROR]: Log Type Not Specified"  >> "$log_name"
        ;;
    esac
}