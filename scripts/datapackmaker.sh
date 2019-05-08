# DataPackMaker v0.1 by: BlockBusterBPL
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
mkfifo /tmp/dpc-formout
form=/tmp/dpc-formout
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
  dialog --inputmenu "Set Starting Options For Your New DataPack" 20 90 5 \
  "Name" "" \
  "Namespace" "" \
  "Author" "" \
  "Min. Version" "" \
  "Max. Version" "" 2> $form
  dpc_name_temp="$(cat dpc-formout | sed '1q;d')"
	dpc_name="${dpc_name_temp#*Name }"
  dpc_namespace_temp="$(cat $form | sed '2q;d')"
	dpc_namespace="${dpc_namespace_temp#*Namespace }"
  dpc_author_temp="$(cat $form | sed '3q;d')"
	dpc_author="${dpc_author_temp#*Author }"
  dpc_min_ver_temp="$(cat $form | sed '4q;d')"
	dpc_min_ver="${dpc_min_ver_temp#*Version }"
  dpc_max_ver_temp="$(cat $form | sed '5q;d')"
	dpc_max_ver="${dpc_max_ver_temp#*Version }"
  cd datapacks
  mkdir "${dpc_name}"
  cd "${dpc_name}"
  mkdir data
  cd data
  mkdir "${dpc_namespace}"
  cd "${dpc_namespace}"
  touch pack.mcmeta
	touch dp_creator.yml
  touch temp__yaml_storage.yml
  yq write temp__yaml_storage.yml pack.format "4"
  yq write temp__yaml_storage.yml pack.description "${dpc_name} By: ${dpc_author}. Created With DPC"
  yq write dp_creator.yml title "${dpc_name}"
  # TODO: More Variables Outputting To YAML Config File
  dpc_router "datapack-home"
}
clear
dpc_router "newdatapack"
