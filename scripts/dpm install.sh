#!/bin/bash

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
      echo "No Package Name Given! Try Again."
else
      
fi
