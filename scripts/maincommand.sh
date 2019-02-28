#!/bin/sh
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"
pwd
parse_yaml() {
   local prefix=$2
   local s='[[:space:]]*' w='[a-zA-Z0-9_]*' fs=$(echo @|tr @ '\034')
   sed -ne "s|^\($s\)\($w\)$s:$s\"\(.*\)\"$s\$|\1$fs\2$fs\3|p" \
        -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p"  $1 |
   awk -F$fs '{
      indent = length($1)/2;
      vname[indent] = $2;
      for (i in vname) {if (i > indent) {delete vname[i]}}
      if (length($3) > 0) {
         vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
         printf("%s%s%s=\"%s\"\n", "'$prefix'",vn, $2, $3);
      }
   }'
}
eval $(parse_yaml packages.yml "package_")
eval $(parse_yaml meta.yml "meta_")
PFX="[DPM]: "
WARN="[WARNING] "
ERR="[ERROR] "
eval D=$(dirname $0)

ProgName=$(basename $0)
sub_create(){
echo "${PFX}Creating New Datapack in world: ${meta_sw_name}"
cd $D
cd ..
cd ..
cd saves
cd ${meta_sw_savename}
echo "${PFX}Name The Datapack:"
read makename
if [ -z "$makename" ] then
mkdir $makename
cd $makename
mkdir data
touch pack.mcmeta
#INSERT BASE PACK DATA HERE
#PACKDATA="json stuff"
#PACKDATA > pack.mcmeta
cd data
echo "${PFX}What will the namespace of your datapack be?"
read namespace
mkdir $namespace
cd $namespace
mkdir advancements
mkdir functions
mkdir loot_tables
mkdir recipes
mkdir structures
mkdir tags
cd tags
mkdir blocks
mkdir items
mkdir fluids
mkdir functions
cd ..
cd ..
cd ..
cd ..
echo "${PFX}Created Datapack with name ${makename}!"
else
	echo "You Did Not Enter A Name!"
fi
}

sub_addnew(){
case $1 in
	"function" )
	#Create New Function
	;;
	"advancement" )
	#Create New Advancement

esac
}

sub_update(){
	if [ $1 = "self" ]
	then
		echo "${PFX}Updating DPM. Current Version: $meta_version."
		wget --show-progress https://github.com/BlockBusterBPL/datapackmanager/archive/master.zip
	else
		echo "oof"
	fi
}
  
sub_help(){
    echo "Usage: $ProgName <subcommand> [options]\n"
    echo "Subcommands:"
    echo "    install:   Install Package"
    echo "    remove:   Remove Package"
    echo "    update:   Update A Package"
    echo "    config:   Change the value of a setting"
    echo ""
    echo "For help with each subcommand run:"
    echo "$ProgName <subcommand> -h|--help"
    echo ""
}

sub_config(){
	echo "${ERR}${PFX}Config Command Not Yet Implemented"
  #property=$1
  #value=$2
  #echo "${PFX}Setting Property $property to $value"
}

sub_install(){
    package=$1
    world=$2
    if [ -z "${package}" ]
then
      echo "${ERR}${PFX}No Package Name Given! Try Again."
else
  echo "${PFX} Installing ${package}"
	INSTALLER="package_"
	INSTALLER+="${package}"
	INSTALLER+="_installurl"
	eval IURL=${!INSTALLER}
	wget --show-progress $IURL
	echo "${PFX}Downloaded $package"
  echo "${PFX}Unzipping..."
	unzip -q master
	RNAME="package_"
	RNAME+="${package}"
	RNAME+="_reponame"
	eval IRNAME=${!RNAME}
	echo "${PFX}Extracted ${IRNAME}, type the savename of the world you want to install to."
	if [ -z "$world" ] then
	read savename
	else
	savename="$world"
	fi
	echo "${PFX}Installing ${IRNAME} to ${savename}..."
	FOLDERNAME=$PWD
	FOLDERNAME+="/"
	FOLDERNAME+=$IRNAME
	FOLDERNAME+="-master"
	echo $FOLDERNAME
	rm master.zip
	cp ${FOLDERNAME} $config_savelocation
fi
}
  
sub_remove(){
  package=$1
  echo "Removing ${package}"
}
  
subcommand=$1
case $subcommand in
    "" | "-h" | "--help")
        sub_help
        ;;
    *)
        shift
        sub_${subcommand} $@
        if [ $? = 127 ]; then
            echo "${ERR}${PFX} '$subcommand' is not a known subcommand." >&2
            echo "       Run '$ProgName --help' for a list of known subcommands." >&2
            exit 1
        fi
        ;;
esac
