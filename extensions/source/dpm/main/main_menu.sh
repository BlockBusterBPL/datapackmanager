#!/bin/bash
dpm_main_menu() {
    dialog --title "DPM" --cancel-label "Exit" --menu "Choose An Option" $h $w 4 \
1 "Select A World" \
2 "Change Global Settings" \
3 "Credits and Information" \
4 "Update Package List" 2> dpm_form

dialogchoice="$( cat < dpm_form )"
case $dialogchoice in
1)
dpm_main_world_select_menu
;;

2)
clear
dpm_main_global_settings
;;

3)
dpm_main_credits
;;

4)
dpm_repos_update_list
;;

*)
clear
echo "An Error Occured With DPM! Error: invalid menu choice"
exit 1
;;
esac
}