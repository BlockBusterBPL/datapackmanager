#!/bin/sh
. parse_yaml.sh
eval $(parse_yaml packages.yml "package_")
eval $(parse_yaml config.yml "config_")
PFX="[DPM]: "
WARN="[WARNING] "
ERR="[ERROR] "


ProgName=$(basename $0)
  
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
  property=$1
  value=$2
  echo "${PFX}Setting Property $property to $value"
}

sub_install(){
    package=$1
    if [ -z "${package}" ]
then
      echo "${ERR}${PFX}No Package Name Given! Try Again."
else
  echo "${PFX} Installing ${package}"
	mkdir ${package}
	cd ${package}
	INSTALLER="package_"
	INSTALLER+="${package}"
	INSTALLER+="_installurl"
	eval IURL=${!INSTALLER}
	wget --show-progress $IURL
	echo "${PFX}Downloaded $package, preparing to install to world: $config_selected-world"
  echo "${PFX}Unzipping..."
  unzip
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
            echo "[Error] [DPM]: '$subcommand' is not a known subcommand." >&2
            echo "       Run '$ProgName --help' for a list of known subcommands." >&2
            exit 1
        fi
        ;;
esac
