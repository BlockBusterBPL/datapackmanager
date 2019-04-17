# DataPackMaker v0.1 by: BlockBusterBPL
# Define Functions
log(){
:
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
clear
main_menu{
dialog 
}
