#!/bin/bash
# install_pkg.sh
dpm_pkg_installer_get_repo_count(){
  ls -1 | wc -l > $dpm_pkg_installer_repo_count
}
dpm_pkg_installer_get_repo_list(){
  cd ${DPM_DIR}/reositories
  ls > $dpm_temp
  for $f in $dpm_temp do
  dpm_pkg_installer_repo_flag="${f}"
  cd $f
  dpm_pkg_installer_repo_name="$(yq r meta.yml meta.name)"
  cd ..
  dpm_pkg_installer_final_item="${dpm_pkg_installer_repo_flag} \"${dpm_pkg_installer_final_item}\"\\ "
  $dpm_pkg_installer_final_item >> $dpm_pkg_temp
  done
}
install_pkg() {
  dialog --menu "Select A Repository" $dpm_h $dpm_w $dpm_pkg_installer_repo_count --file $dpm_pkg_temp
}
