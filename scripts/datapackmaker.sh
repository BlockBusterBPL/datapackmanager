#!/bin/bash
# DataPackMaker v0.1 by: BlockBusterBPL
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# Define Functions
source errorhandler.sh
log(){
:
}
mkcd(){ # Make And Enter Directory
mkdir "$1"
cd "$1"
}
program_exit(){
  errorhandler "dpc" $1
  exit 1
}
log_init(){ # Initialize Logger
  mkfifo /tmp/dpc-log # Create Named Pipe For Log
}
log_teardown(){ # Tear Down and Close The Logger
:
}
handle_changeover(){ # Handles A Seamless Switch From DPM to DPC
rm "${DIR}/dpc-formout"
mkfifo "${DIR}/dpc-formout"
form="${DIR}/dpc-formout"
}
handle_reverse_changeover(){ # Handles A Seamless Switch From DPC to DPM
:
}
dpc_router(){
case $1 in
  "mainmenu")
    main_menu
    ;;
  "newdatapack")
    datapack_createnew
    ;;
  "datapack-home")
    datapack_home
    ;;
  "changeover-to-dpm")
    handle_reverse_changeover
    ;;
  "datapack-list")
    my_data_packs
    ;;
"initialize-dpc")
		handle_changeover
		dpc_router "mainmenu"
		;;
  *)
  	program_exit 2 # Exit With 'Router Error: Invalid Option', Code 2
  ;;
esac
}
main_menu(){
dialog
}
datapack_home(){
	:
}
datapack_createnew(){
	cd ../datapacks
  log "Creating New DataPack"
  dialog --inputbox "Enter the name of your new datapack" 20 90 2> $form
	dpc_name="${form}"
  dialog --inputbox "Enter a description for your datapack" 20 90 2> $form
	dpc_namespace="${form}"
  dialog --inputbox "Enter the name you want to appear as the author" 20 90 2> $form
	dpc_author="${form}"
  mkdir "${dpc_name}"
  cd "${dpc_name}"
  mkdir data
  cd data
  mkdir "${dpc_namespace}"
  cd "${dpc_namespace}"
  touch pack.mcmeta
	touch dp_creator.yml
  touch temp__yaml_storage.yml
  echo "---\n***"
  yq write temp__yaml_storage.yml pack.format "4"
  yq write temp__yaml_storage.yml pack.description "${dpc_name} By: ${dpc_author}. Created With DPC"
  yq write dp_creator.yml title "${dpc_name}"
  # TODO: More Variables Outputting To YAML Config File
  clear
  dpc_router "datapack-home"
}
clear
handle_changeover
dpc_router "newdatapack"
