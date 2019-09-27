#!/bin/bash
# install_pkg.sh
source ../repos/
dpm_pkg_installer_get_repo_count(){
  ls -1 | wc -l
}
install_pkg() {
  dialog --menu "Select A Repository" $dpm_h $dpm_w
}
