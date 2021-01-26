#!/bin/bash
dpm_main_global_settings() {
    dialog --title "DPM / Global Settings"  --menu "" $h $w 5 \
  1 "Locate Minecraft installation" \
  2 "Check For Updates" \
  3 "Install Development Tools" \
  4 "Change Installation Branch" \
  5 "Clear Log Files" 2> dpm_form

  dialogchoice="$( cat < dpm_form )"
    case $dialogchoice in
    1)
    dpm_main_user_location
    ;;

    2)
    dpm_main_global_settings
    ;;

    3)
    dpm_main_credits
    ;;

    4)
    dpm_main_branch_switcher
    ;;

    5)
    log_setup clear_logs
    ;;

    *)
    clear
    echo "An Error Occured With DPM! Error: invalid menu choice"
    exit 1
    ;;
    esac
    
}