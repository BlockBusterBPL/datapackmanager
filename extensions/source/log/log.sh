#!/bin/bash
log() {
    log_time=$(date +"%T")
    case $1 in 
        N)
            echo "[$log_time] [INFO]: $2"
        ;;
        W)
            echo "[$log_time] [WARN]: $2"
        ;;
        E)
            echo "[$log_time] [ERROR]: $2"
        ;;
        *)
            echo "[$log_time] [ERROR]: Log Type Not Specified"
        ;;
    esac
}