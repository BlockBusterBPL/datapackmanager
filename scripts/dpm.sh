#!/bin/sh
. parse_yaml.sh #include YAML parser
eval $(parse_yaml packages.yml "package_")
#eval $(parse_yaml configuration.yml "config_")
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
if [ "$MODE" = "install" ]
if [ -z "$PACKAGE" ]
then
      echo "${PFX}${ERR}No Package Name Given! Try Again."
else
	echo "${PFX}Getting Install URL"
	echo "${PFX}Grabbed Install URL For $PACKAGE"
	if [ -d ${PACKAGE} ]
			mkdir ${PACKAGE}
	else
	rmdir ${PACKAGE}
	mkdir ${PACKAGE}
	fi
	cd ${PACKAGE}
	wget $package_testfile_installurl --show-progress
	echo "${PFX}Downloaded $package_testfile_normalname"
fi
else
	
	if []

	else
	
	fi
	
fi