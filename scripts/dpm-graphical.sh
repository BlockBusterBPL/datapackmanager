#####################################
# DPM Graphical by BlockBusterBPL   #
# Do Not Copy Without Authorization #
# This Script Will Not Run Without  #
# The installer being run first!    #
#####################################

version="0.1"
clear
mkfifo /tmp/dialogchoice

FullWidth=$(tput cols)
FullHeight=$(tput lines)
h=$(($FullHeight / 2))
w=$(($FullWidth / 2))

world_select(){
worlds_string="$(yq read "./worlds.yml" worldnames)"
worlds=($worlds_string)
worlds_length${#worlds[@]}
dialog --menu "Choose A World" $h $w ${worlds_length} \
# TODO: More World List Expanding Here!
}

global_settings(){
  dialog --title "DPM / Global Settings" --menu "" $h $w 3 \
  1 "Add Or Remove World Configurations" \
  2 "Check For Updates" \
  3 "Install Development Tools"
}

install(){
dialog --inputbox "Type The Name Of The Package You Want To Install" $h $w 2> $package
yq read "packages/datapacks/${package}.yml" normalname 2> $pkgname
yq read "packages/datapacks/${package}.yml" installurl 2> $pkginst
yq read "packages/datapacks/${package}.yml" filename 2> $filename
cd ../../saves/${worldsave}/datapacks/
dialog --progressbox "Downloading ${pkgname}" 44 66 | wget -q $pkginst
dialog --progressbox "Installing ${pkgname}" 44 66 | unzip -q $filename
dialog --progressbox "Cleaning Up" 44 66 | rm -f $filename
dialog --pause "DPM Successfully Installed ${pkgname} Into Your Minecraft World! The Game Is Now Ready To Play." $h $w 5
dpm interface
}
remove(){
:
}
devkit(){
:
}
updatelist(){
cd "../repositories/dpm-official"
git pull | dialog --progressbox "Updating Package List..." $h $w
cd "../../scripts/"
clear
}
dialog --title "DPM" --menu "Choose An Option" $h $w 4 \
1 "Select A World" \
2 "Change Global Settings" \
3 "Credits and Information" \
4 "Update Package List" 2> dialogchoice

dialogchoice="$( cat < dialogchoice )"

case $dialogchoice in
1)
world_select
;;

2)
clear
global_settings
;;

3)
devkit
;;

4)
updatelist
;;

*)
clear
echo "An Error Occured With DPM! Error: invalid menu choice"
exit 1
;;
esac
