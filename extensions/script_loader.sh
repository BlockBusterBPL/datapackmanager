#!/bin/bash  
script_loader() {
  # DEFINE EXT DIRECTORY
  LOG_DIR="${DPM_DIR}/logs"
  CFG_DIR="${DPM_DIR}/config"
  EXT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
  # CREATE TEMP FILES FOR DIALOG
  cd extensions
  rm -rf "${EXT_DIR}/temp/"
  mkdir "${EXT_DIR}/temp"
  mkfifo "${EXT_DIR}/temp/dpm-form"
  dpm_form="${EXT_DIR}/temp/dpm-form"
  mkfifo "${EXT_DIR}/temp/dpm-temp"
  dpm_temp="${EXT_DIR}/temp/dpm-temp"
  mkfifo "${EXT_DIR}/temp/dpm-pkg-temp"
  dpm_pkg_temp="${EXT_DIR}/temp/dpm-pkg-temp"
  # DEFINE DIALOG HEIGHT AND WIDH
  dpm_script_loader_width=$(tput cols)
  dpm_script_loader_height=$(tput lines)
  w=$(($dpm_script_loader_width / 2))
  h=$(($dpm_script_loader_height / 2))
  
  OIFS="$IFS"
  IFS=$'\n'
  # DEFINE LOAD ORDER
  #for f in ${DPM_DIR}/extensions/lib/*; do source $f; done #External Libraries for dpm
  for g in $(find "${DPM_DIR}/extensions/source" -type f -print); do source $g; done # DPM Source Code
  #for h in ${DPM_DIR}/extensions/addons/*; do source $h; done # External Mods to DPM
  IFS="$OIFS"
}
