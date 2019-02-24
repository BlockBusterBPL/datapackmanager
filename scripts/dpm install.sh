#!/bin/bash
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
echo "${PFX} Installing Package ${PACKAGE}"
if [ -z "$PACKAGE" ]
then
      echo "${PFX} ${ERR} No Package Name Given! Try Again."
else
	echo "Getting Install URL"
	InstallURL=${packages_${PACKAGE}_install-url}
	cd temp/
	mkdir ${PACKAGE}
	cd ${PACKAGE}
	wget  ${InstallURL} -q --show-progress
	echo "${PFX} Downloaded ${packages_${package}_normal-name}"
fi
