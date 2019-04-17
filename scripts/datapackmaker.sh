# DataPackMaker v0.1 by: BlockBusterBPL
# Define Functions
source errorhandler-dpc.sh
log(){
:
}
program_exit(){
  code="$1"
  errorhandler-dpc $code
}
log_init(){ # Initialize Logger
  mkfifo dpc-log # Create Named Pipe For Log
  
}
log_teardown(){ # Tear Down and Close The Logger
:
}
handle_changeover(){ # Handles A Seamless Switch From DPM to DPC
:
}
handle_reverse_changeover(){ # Handles A Seamless Switch From DPC to DPM
:
}
main_menu{
dialog
}
datapack_createnew(){
  log "Creating New DataPack"
  dialog --form
}
clear
