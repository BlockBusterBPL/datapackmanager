clear
echo "starting installer"
: ${DIALOG_OK=0}
: ${DIALOG_CANCEL=1}
: ${DIALOG_HELP=2}
: ${DIALOG_EXTRA=3}
: ${DIALOG_ITEM_HELP=4}
: ${DIALOG_ESC=255}
create_temp(){
  tempid=$1
  touch "/tmp/dpm/${tempid}.$$"
  eval temp${tempid}="/tmp/dpm/${tempid}.$$"
}
echo "Checking Required Dependancies... The Installer Will Continue When This Operation Is Done"
FullWidth=$(tput cols)
FullHeight=$(tput lines)
h=$(($FullHeight / 2))
w=$(($FullWidth / 2))
Reqs=(dialog yq git unzip wget)
if (( dialog && yq && git && unzip && wget )) ; then
:
else
clear
echo "One or more libraries were not found! Make sure they are installed before you run this script!"
exit 1
fi
clear

dialog --checklist "Select Options To Install:" $h $w 2 \
1 "DPM Core (Required)" 1 \
2 "GamePack Development Kit" 0 \

if grep -q "Preinstall Package List" /tmp/choice.$$ ; then
    PkgList="true"
fi
if grep -q "GamePack Development Kit" /tmp/choice.$$ ; then
    DevKit="true"
fi
clear
cd "~/Library/Application\ Support/minecraft"
git clone -v https://www.github.com/BlockBusterBPL/datapackmanager | dialog --progressbox "Downloading Files From GitHub..." $h $w
if [ "$DevKit" = "true" ] ; then
:
fi
if [ "$PkgList" = "true" ] ; then

fi
sleep 2
dialog --msgbox "Installation Complete! Type 'dpm' to start first-time setup." $h $w
clear
