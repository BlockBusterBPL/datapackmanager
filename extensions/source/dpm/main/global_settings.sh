#!/bin/bash
dpm_main_global_settings() {
    dialog --title "DPM / Global Settings"  --menu "" $h $w 4 \
  1 "Add Or Remove World Configurations" \
  2 "Check For Updates" \
  3 "Install Development Tools" \
  4 "Change Installation Branch" 2> dpm_form

  dialogchoice="$( cat < dpm_form )"
    case $dialogchoice in
    1)
    dpm_main_world_select_menu
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

    *)
    clear
    echo "An Error Occured With DPM! Error: invalid menu choice"
    exit 1
    ;;
    esac
    
}