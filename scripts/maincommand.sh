#!/bin/sh
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"
PFX="[DPM]: "
WARN="[WARNING] "
ERR="[ERROR] "
D=$DIR
YRM="yq read meta.yml"
YRP="yq read packages.yml"
ProgName=$(basename $0)
world=$($YRM selectedworld.path)
sub_create(){
echo "${PFX}Creating New Datapack in world: $($YRM selectedworld.name)"
cd $D
cd ..
cd ..
cd saves
cd $($YRM selectedworld.savename)
echo "${PFX}Name The Datapack:"
read makename
if [ -z "$makename" ]
then
		echo "You Did Not Enter A Name!"
else
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
    if [ -z "${package}" ];
then
      echo "${ERR}${PFX}No Package Name Given! Try Again."
else
  echo "${PFX} Installing ${package}"
	eval IURL=$($YRP ${package}.installurl)
	wget --show-progress $IURL
	echo "${PFX}Downloaded $package"
  echo "${PFX}Unzipping..."
	unzip -q -o master
	IRNAME=$($YRP ${package}.reponame)
	if [ -z "${world}" ]; then
	echo "${PFX}Extracted ${IRNAME}, type the savename of the world you want to install to."
	read savename
	else
	savename="$world"
	fi
	echo "${PFX}Installing ${IRNAME} to ${savename}..."
	FOLDERNAME="$PWD"
	FOLDERNAME+="/"
	FOLDERNAME+=$IRNAME
	FOLDERNAME+="-master"
	echo $FOLDERNAME
	rm master.zip
	cp -r "${FOLDERNAME}" "$($YRM worlds.prefix)/$savename/datapacks"
	rm -r "${FOLDERNAME}"
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
