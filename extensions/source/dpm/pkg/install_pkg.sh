#!/bin/bash
# install_pkg.sh
dpm_install_pkg_get_repo_count(){
  ls -1 | wc -l > $dpm_pkg_installer_repo_count
}
dpm_install_pkg_get_repo_list(){
  cd "${DPM_DIR}/repositories"
  ls > $dpm_temp
  for f in $dpm_temp; do
  dpm_pkg_installer_pkg_flag=$f
  cd $f
  dpm_pkg_installer_pkg_name="$(yq r meta.yml meta.name)"
  cd ..
  dpm_pkg_installer_final_item="${dpm_pkg_installer_pkg_flag} \"${dpm_pkg_installer_pkg_name}\"\\ "
  $dpm_pkg_installer_final_item >> $dpm_pkg_temp
  done
}
dpm_install_pkg_show_repo() {
  dialog --menu "Select A Repository" $dpm_h $dpm_w $dpm_pkg_installer_repo_count --file $dpm_pkg_temp 2> $dpm_temp
}
dpm_install_pkg_get_package_length(){
  cd $(cat $dpm_temp)
  cd $(yq r meta.yml features.packages.location)
  ls -1 | wc -l > $dpm_pkg_installer_pkg_count
}
dpm_install_pkg_get_package_list(){
  ls > $dpm_pkg_installer_items
  for f in $dpm_pkg_installer_items; do
  dpm_pkg_installer_pkg_flag="${f}"
  cd $f
  dpm_pkg_installer_pkg_name="$(yq r ${f}.yml meta.name)"
  cd ..
  dpm_pkg_installer_final_item="${dpm_pkg_installer_pkg_flag} \"${dpm_pkg_installer_pkg_name}\"\\ "
  $dpm_pkg_installer_final_item >> $dpm_pkg_temp
  done
}
dpm_install_pkg_select_package(){
  dialog --menu "Chose a package to install" $h $w --file $dpm_pkg_temp 2> $dpm_temp
}
dpm_install_pkg_actual_install() {
  git_repo=$(yq r ${dpm_install_pkg_name}.yml 1 install.address)
  cd ${dpm_staging_system_directory}
  git submodule add ${git_repo}
  git submodule update
}
dpm_install_pkg(){
  dpm_install_pkg_get_repo_count
  wait
  dpm_install_pkg_get_repo_list
  wait
  dpm_install_pkg_show_repo
  wait
  dpm_install_pkg_get_package_list
  wait
  dpm_install_pkg_select_package
  wait
  dpm_install_pkg_actual_install
}
