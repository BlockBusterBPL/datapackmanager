#!/bin/bash

dpm_staging_system_menu_continue() {
  dialog --menu "Pkg added to stage. Install?" $w $h \
  install "Install Mods" \
  continue "Back to Mods" \
  home "Go to Home" 2> $dpm-form
  case $f in $(cat $dpm-form)
  install)
  dpm_staging_install
  ;;
  continue)
  dpm_install_pkg
  ;;
  home)
  dpm_router main_menu
  ;;
  *)
  exit
  ;;
  esac
}
dpm_staging_install(){
:
}
