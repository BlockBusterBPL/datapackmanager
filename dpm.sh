#!/bin/bash
#sudo echo "Root Enabled"
DPM_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source extensions/script_loader.sh
script_loader
#log_setup first_init
log_setup init
log N "Log Started"
log N "Scripts Loaded"
wait
log N "Starting Main Menu"
dpm_main_menu
