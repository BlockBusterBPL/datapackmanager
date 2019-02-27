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


ProgName=$(basename $0)

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
	read savename
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
