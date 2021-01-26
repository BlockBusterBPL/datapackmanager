#!/bin/bash
#sudo echo "Root Enabled"
source extensions/script_loader.sh
DPM_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
script_loader
wait
dpm_main_menu
