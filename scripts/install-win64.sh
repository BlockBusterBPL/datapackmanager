cd ~
echo "Installing DPM..."
echo "Written By BlockBusterBPL: https://github.com/blockbusterbpl"
echo "Do Not Distribute Without Express Permission!"
echo "Please Wait 5 Seconds"
sleep 5s

#$BPCODE="Bash Code Here"
#$BPCODE >> .bash_profile
echo "Getting Dependencies..."
$HDIR="C:\Program\ Files\Git\mingw64\bin"
cd $HDIR
echo "Installing wget"
if ! [ -f "wget.exe" ]; then
  curl -o --progress-bar wget.exe "https://eternallybored.org/misc/wget/1.20/64/wget.exe"
fi
echo "Installed wget"
echo "Installing yq..."
wget --show-progress --no-clobber https://github.com/mikefarah/yq/releases/download/2.2.1/yq_windows_amd64.exe
echo "Installed yq"
echo "Installing Main Scripts"
cd appdata/roaming/.minecraft
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
echo "Installation Complete! Type 'dpm help' for command usage"
