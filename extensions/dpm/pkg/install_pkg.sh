#!/bin/bash
# install_pkg.sh
dpm_install_pkg_get_repo_count(){
  ls -1 | wc -l > $dpm_pkg_installer_repo_count
}
dpm_install_pkg_get_repo_list(){
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
dpm_install_pkg_show_repo() {
  dialog --menu "Select A Repository" $dpm_h $dpm_w $dpm_pkg_installer_repo_count --file $dpm_pkg_temp 2> $dpm_temp
}
dpm_install_pkg_get_package_list(){
:
}
dpm_install_pkg_select_package(){
:
}
dpm_install_pkg_actual_install() {
  git_repo=$(yq r ${dpm_install_pkg_name}.yml 1 install.address)
  cd ${dpm_staging_system_directory}
  git submodule add ${git_repo}
  git submodule update
  dpm_staging_system_menu_continue
}
