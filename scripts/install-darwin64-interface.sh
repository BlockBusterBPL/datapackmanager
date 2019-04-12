clear
echo "starting installer"
: ${DIALOG_OK=0}
: ${DIALOG_CANCEL=1}
: ${DIALOG_HELP=2}
: ${DIALOG_EXTRA=3}
: ${DIALOG_ITEM_HELP=4}
: ${DIALOG_ESC=255}
echo "Checking Required Libraries... The Installer Will Continue When This Operation Is Done"
$FullWidth=$(tput cols)
$FullHeight=$(tput lines)
h=$(($FullHeight / 2))
w=$(($FullWidth / 2))
if (( colortest && dialog && yq && git && unzip )) ; then
:
else
clear
echo "One or more libraries were not found! Make sure they are installed before you run this script!"
wait 3
exit 1
fi
pkg_install() {
  git clone https://www.github.com/blockbusterbpl/dpm-packages packages
}
clear

dialog --fselect "Please Navigate To Your Minecraft Installation:" $h $w 2> $location
cd $location



dialog --checklist "Select Options To Install:" $h $w 4 \
1 "DPM Core (Required)" 1 \
2 "GamePack Development Kit" 0 \
3 "Preinstall Package List" 0 \
4 "stuff" 0

DevKit=$(yq read "installconfig.yml" install.devkit )
PkgList=$(yq read "installconfig.yml" install.pkglist )

clear

dialog --progressbox "Downloading Files From GitHub..." $h $w | wget -q https://www.github.com/
dialog --progressbox "Unzipping Files..." 17 66 | unzip master.zip
if [ $DevKit = "true" ] ; then
  dialog --progressbox "Downloading Development Kit..." $h $w | wget -q https://www.github.com/
fi
if [ $PkgList = "true" ] ; then
  dialog --progressbox "Updating Package List..." $h $w | package_install()
fi
dialog 
