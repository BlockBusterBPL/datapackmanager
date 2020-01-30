#!/bin/bash  
script_loader() {
  DPM_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
  rm -rf "${DPM_DIR}/temp/"
  mkfifo "${DPM_DIR}/temp/dpm-form"
  dpm_form="${DPM_DIR}/temp/dpm-form"
  mkfifo "${DPM_DIR}/temp/dpm-temp"
  dpm_temp="${DPM_DIR}/temp/dpm-temp"
  mkfifo "${DPM_DIR}/temp/dpm-pkg-temp"
  dpm_pkg_temp="${DPM_DIR}/temp/dpm-pkg-temp"
  for f in ${DPM_DIR}/extensions/libraries/*; do source $f; done
  for g in ${DPM_DIR}/extensions/dpm-source/*; do source $g; done
  for h in ${DPM_DIR}/extensions/overrides/*; do source $h; done
}
