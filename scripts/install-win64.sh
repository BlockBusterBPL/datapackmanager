cd ~
echo "Installing DPM..."
#$BPCODE="Bash Code Here"
#$BPCODE >> .bash_profile
echo "Getting Dependencies..."
$HDIR="C:\Program\ Files\Git\mingw64\bin"
cd $HDIR
echo "Installing wget"
if ! [ -f "wget.exe" ]; then
  curl -o -# wget.exe "https://eternallybored.org/misc/wget/1.20/64/wget.exe"
fi
echo "Installed wget"
echo "Installing yq..."
wget --show-progress --no-clobber https://github.com/mikefarah/yq/releases/download/2.2.1/yq_windows_amd64.exe
echo "Installed yq"

cd appdata/roaming/.minecraft
mkdir datapackmanager
cd datapackmanager
