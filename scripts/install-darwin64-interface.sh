echo "starting installer"
: ${DIALOG_OK=0}
: ${DIALOG_CANCEL=1}
: ${DIALOG_HELP=2}
: ${DIALOG_EXTRA=3}
: ${DIALOG_ITEM_HELP=4}
: ${DIALOG_ESC=255}
echo "Checking Required Libraries..."
if [ colortest ] ; then
:
else
echo "One or more libraries were not found! Make sure they are installed before you run this script!"
wait 3
exit 1
fi
dialog --checklist "Select Options To Install:" 17 66 4 \
1 "DPM Core (Required)" 1 \
2 "GamePack Development Kit" 0 \
3 "Preinstall Package List" 0 \
4 "stuff" 0

clear

dialog --gauge "Installation Progress" 17 66 0

clear

dialog --msgbox "An Error Has Occured! \n The installation will now exit..." 17 66
wait
clear
echo "An Error Occured! Code: 2: Installation Error Occured... No Further Information"
exit 1
