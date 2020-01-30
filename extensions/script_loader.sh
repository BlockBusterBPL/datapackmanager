#!/bin/bash  
script_loader() {
  # DEFINE DPM DIRECTORY
  DPM_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
  # CREATE TEMP FILES FOR DIALOG
  rm -rf "${DPM_DIR}/temp/"
  mkfifo "${DPM_DIR}/temp/dpm-form"
  dpm_form="${DPM_DIR}/temp/dpm-form"
  mkfifo "${DPM_DIR}/temp/dpm-temp"
  dpm_temp="${DPM_DIR}/temp/dpm-temp"
  mkfifo "${DPM_DIR}/temp/dpm-pkg-temp"
  dpm_pkg_temp="${DPM_DIR}/temp/dpm-pkg-temp"
  # DEFINE DIALOG HEIGHT AND WIDH
  dpm_script_loader_width=$(tput cols)
  dpm_script_loader_height=$(tput lines)
  h=$(($dpm_script_loader_width / 2))
  w=$(($dpm_script_loader_height / 2))
  # DEFINE LOAD ORDER
  for f in ${DPM_DIR}/scripts/libraries/*; do source $f; done
  for g in ${DPM_DIR}/scripts/dpm-source/*; do source $g; done
  for h in ${DPM_DIR}/scripts/addons/*; do source $h; done
}
