###################################
# DPM Graphical by BlockBusterBPL
# 
# 
# 
###################################
version="0.1"
clear
dialog --title "DPM" --menu "Choose An Option" 44 66 4 \
1 "Select A World" \
2 "Change Global Settings" \
3 "Credits and Information" \
4 "Update Package List" 

world_select(){
yq read "./worlds.yml" worldnames
}

global_settings(){
  dialog --title "DPM / Global Settings" --menu "" 44 66 3 \
  1 "Add Or Remove World Configurations" \
  2 "Check For Updates" \
  3 "Install Development Tools"}

install(){
dialog --inputbox "Type The Name Of The Package You Want To Install" 44 66 2> $package
yq read "packages/datapacks/${package}.yml" normalname 2> $pkgname
yq read "packages/datapacks/${package}.yml" installurl 2> $pkginst
yq read "packages/datapacks/${package}.yml" filename 2> $filename
cd ../../saves/${worldsave}/datapacks/
dialog --progressbox "Downloading ${pkgname}" 44 66 | wget -q $pkginst
dialog --progressbox "Installing ${pkgname}" 44 66 | unzip -q $filename
dialog --progressbox "Cleaning Up" 44 66 | rm -f $filename
dialog --pause "DPM Successfully Installed ${pkgname} Into Your Minecraft World! The Game Is Now Ready To Play." 44 66 5
dpm interface
}
remove(){
:
}
devkit(){
:
}
updatelist(){
cd ${ID}/packages
dialog --progressbox "Updating Package List..." | git pull -q
cd ..
dpm interface
}
