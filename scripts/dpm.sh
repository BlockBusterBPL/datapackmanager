#!/bin/sh
. parse_yaml.sh #include YAML parser
eval $(parse_yaml packages.yml "package_")
eval $(parse_yaml config.yml "config_")
POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -p|--package)
    PACKAGE="$2"
    shift # past argument
    shift # past value
    ;;
    -m|--mode)
    MODE="$2"
    shift # past argument
    shift # past value
    ;;
    -r|--reset)
    RESET="$2"
    shift # past argument
    shift # past value
    ;;
    -u|--update)
    UPDATE=YES
    shift # past argument
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters
PFX="[DPM]: "
WARN="[WARNING] "
ERR="[ERROR] "
if [ -z "${PACKAGE}" ]
then
      echo "${PFX}${ERR}No Package Name Given! Try Again."
else
	echo "${PFX}Getting Install URL"
	echo "${PFX}Grabbed Install URL For $PACKAGE"
	mkdir ${PACKAGE}
	cd ${PACKAGE}
	INSTALLER="package_"
	INSTALLER+="${PACKAGE}"
	INSTALLER+="_installurl"
	eval IURL=${!INSTALLER}
	wget --show-progress $IURL
	echo "${PFX}Downloaded $PACKAGE"
fi