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
if [UPDATE=YES]
echo "${PFX} Updating ${PACKAGE}"
else
	echo "${PFX}Getting Install URL"
	echo "${PFX}Grabbed Install URL For $PACKAGE"
	mkdir ${PACKAGE}
	cd ${PACKAGE}
	DOWNLOADURL="package_" #Create Variable With package_
	DOWNLOADURL+="${PACKAGE}" #Add package name to variable
	DOWNLOADURL+="_installurl" #Add _installurl to variable
	eval IURL=${!DOWNLOADURL}
	wget --show-progress $IURL
	echo "${PFX}Downloaded $PACKAGE"
	fi
fi
