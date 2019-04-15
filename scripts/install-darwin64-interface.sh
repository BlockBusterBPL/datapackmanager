clear
echo "starting installer"
: ${DIALOG_OK=0}
: ${DIALOG_CANCEL=1}
: ${DIALOG_HELP=2}
: ${DIALOG_EXTRA=3}
: ${DIALOG_ITEM_HELP=4}
: ${DIALOG_ESC=255}
echo "Checking Required Libraries... The Installer Will Continue When This Operation Is Done"
FullWidth=$(tput cols)
FullHeight=$(tput lines)
h=$(($FullHeight / 2))
w=$(($FullWidth / 2))
#if (( dialog && yq && git && unzip )) ; then
#:
#else
#clear
#echo "One or more libraries were not found! Make sure they are installed before you run this script!"
#exit 1
#fi
pkg_install() {
  git clone https://www.github.com/blockbusterbpl/dpm-packages packages
}
clear

dialog --checklist "Select Options To Install:" $h $w 3 \
1 "DPM Core (Required)" 1 \
2 "GamePack Development Kit" 0 \
3 "Preinstall Package List" 0

if grep -q "Preinstall Package List" /tmp/choice.$$ ; then
    PkgList="true"
fi
if grep -q "GamePack Development Kit" /tmp/choice.$$ ; then
    DevKit="true"
fi
clear
cd ~/Library/Application\ Support/minecraft
rm -rf master.zip
rm -rf datapackmanager-master
rm -rf newdpm
wget -q https://www.github.com/BlockBusterBPL/datapackmanager/archive/master.zip | dialog --progressbox "Downloading Files From GitHub..." $h $w
unzip -o master.zip | dialog --progressbox "Unzipping Files..." 17 66
rm -rf master.zip
mv datapackmanager-master newdpm
rm -rf datapackmanager-master
if [ "$DevKit" = "true" ] ; then
dialog --progressbox "Downloading Development Kit..." $h $w #| wget -q https://www.github.com/
fi
if [ "$PkgList" = "true" ] ; then
dialog --progressbox "Updating Package List..." $h $w #| package_install
fi
sleep 2
dialog --msgbox "Installation Complete! Type 'dpm' to start first-time setup." $h $w
clear
