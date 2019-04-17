# DataPackMaker v0.1 by: BlockBusterBPL
# Define Functions
source errorhandler-dpc.sh
log(){
:
}
mkcd(){ # Make And Enter Directory
mkdir "${1}"
cd "${1}"
}
program_exit(){
  code="$1"
  errorhandler dpc $code
  exit 1
}
log_init(){ # Initialize Logger
  mkfifo dpc-log # Create Named Pipe For Log
  
}
log_teardown(){ # Tear Down and Close The Logger
:
}
handle_changeover(){ # Handles A Seamless Switch From DPM to DPC
mkfifo dpc-formout
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
  *)
  program_exit 2 # Exit With 'Router Error: Invalid Option', Code 2
  ;;
}
main_menu{
dialog
}
datapack_createnew(){
  log "Creating New DataPack"
  dialog --title "DataPackCreator - v0.1" --inputmenu "Set Starting Options For Your New DataPack" $h $w 5 \
  1 "Name" \
  2 "Namespace" \
  3 "Author" \
  4 "Min. Version" \
  5 "Max. Version" 2> dpc-formout
  dpc-name="$(cat dpc-formout | sed '1q;d')"
  dpc-namespace="$(cat dpc-formout | sed '2q;d')"
  dpc-author="$(cat dpc-formout | sed '3q;d')"
  dpc-min-ver="$(cat dpc-formout | sed '4q;d')"
  dpc-max-ver="$(cat dpc-formout | sed '5q;d')"
  cd datapacks/
  mkdir "${dpc-name}"
  mkdir "${dpc-namespace}"
  cd "${dpc-namespace}"
  touch pack.mcmeta
  touch dpc-packdata.yml
  $dpdata="$(PWD)/dpc-packdata.yml"
  yq write $dpdata title "${dpc-name}"
  # TODO: More Variables Outputting To YAML Config File
  dpc_router "datapackhome"
}
clear
