#!/bin/bash
cd ~
echo "The Installation Requires An Admin Name And Password (We Won't Share It!)"
sudo echo "Authentication Complete"
echo "Installing DPM For Darwin (Now Mac OS)"
echo "Checking If Homebrew is installed..."
if brew ; then
    echo "Homebrew Installed! Installing Dependancies."
else
    echo "Homebrew Not Installed! Downloading Now."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    wait
fi
brew install wget
wait
brew install yq
wait
echo "Installed Dependancies! Ready To Continue..."
cd Library/Application\ Support/minecraft
mkdir datapackmanager
cd datapackmanager
wget --show-progress https://github.com/BlockBusterBPL/datapackmanager/archive/zip/master.zip
unzip master
rm master.zip
echo "Download Complete, Registering Scripts..."
cd scripts/
chmod +x maincommand.sh
cd ..
touch firstrun.txt
OOF="true" > firstrun.txt
