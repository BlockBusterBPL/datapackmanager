#!/bin/bash
dpm_repos_update_list() {
  git submodule init
  git submodule update -v | dialog --progressbox "Updating Package List..." $h $w --sleep 2
  dialog --pause "Update Complete" $h $w 2
  dpm_main_menu
}
