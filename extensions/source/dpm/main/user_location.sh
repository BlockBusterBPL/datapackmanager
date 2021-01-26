#!/bin/bash
dpm_main_user_location() {
    dialog --menu "Select your console type" $h $w 3 \
    unix "Generic Unix" \
    wsl "Windows Subsystem Linux" \
    mac "MacOS" 2> dpm_form
    dialogchoice="$( cat < dpm_form )"
    case $dialogchoice in
    unix)
    dpm_main_user_location_unix
    ;;

    wsl)
    dpm_main_user_location_wsl
    ;;

    mac)
    dpm_main_user_location_mac
    ;;

    *)
    clear
    echo "An Error Occured With DPM! Error: invalid menu choice"
    exit 1
    ;;
    esac
}

dpm_main_user_location_wsl(){
    dialog --title "Select your user folder" --dselect "/mnt/c/Users/" $h $w 2> dpm_form
    MC_DIR="$(cat < dpm_form)/AppData/Roaming/.minecraft"
    yq eval --inplace ".mc_dir = \"${MC_DIR}\"" "${CFG_DIR}/dpm.yml" #> "${CFG_DIR}/dpm.yml"

}
dpm_main_user_location_mac(){
    dialog --title "Select your minecraft folder" --dselect "/Library/Application\ Support/" $h $w 2> dpm_form
}
dpm_main_user_location_unix(){
    dialog --title "Select your minecraft folder" --dselect "/var/games/" $h $w 2> dpm_form
}