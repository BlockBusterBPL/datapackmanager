#!/bin/bash  
dpm_init() {
  DPM_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
  rm -rf "${DPM_DIR}/temp/"
  mkfifo "${DPM_DIR}/temp/dpm-form"
  dpm_form="${DPM_DIR}/temp/dpm-form"
  git submodule update --init --recursive
}
