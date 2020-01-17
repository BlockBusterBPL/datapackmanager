#!/bin/bash  
script_loader() {
  DPM_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
  rm -rf "${DPM_DIR}/temp/"
  mkfifo "${DPM_DIR}/temp/dpm-form"
  dpm_form="${DPM_DIR}/temp/dpm-form"
  for f in ${DPM_DIR}/extensions/*; do source $f; done
}
