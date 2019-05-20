repo_clone() {
  # Change to repos directory
  git clone $1 # In Dialog
  yq write repos.yml installed.[+] "$1"
}
repo_remove() {
  # Change to repos directory
  rm -rf "$1"
  yq remove repos.yml installed."$1"
  yq remove repos.yml refrenced."$1"
}
repo_add() {
  yq write repos.yml refrenced.[+] "$1"
  clone_repo "$1"
}
make_repo_list(){
  yq read repos.yml referenced | wc -l | cut -f1 -d" " > $TEMP_height
  LIST_HEIGHT="$(($TEMP_height-1))"
  dialog_start='dialog --seperate-output --buildlist "Manage Repositories" 60 40 $LIST_HEIGHT \\'
  for $1 in $(yq read repos.yml referenced)
  do
  dp_reponame="$(yq read repos.yml referenced.${1}.name)"
  dialog_item='$dp_reponame "${dp_normalname}" off \\$'\n''
  done
  for $1 in $(yq read repos.yml installed)
  do
  dp_reponame="$(yq read repos.yml installed.${1}.name)"
  dialog_item='$dp_reponame "${dp_normalname}" on \\$'\n''
  dialog_start+='$dialog_item'
  done
  $dialog_start
}
manage_repos(){
  dialog --seperate-output --buildlist "Manage Repositories" 60 40 $LIST_HEIGHT \
  default "Default Repository" on \
  test1 "Test Extra Repo On" on \
  test2 "Test Extra Repo Off" off 2> $TEMP_MANAGER
  yq write repos.yml installed null
  for $1 in $(cat $TEMP_MANAGER)
  do
    repolink="$(yq read repos.yml refrenced."$1".repourl)"
    git clone "reponame" $repolink
    yq write repos.yml installed.[+] $1
  done
}
repomanager(){
  :
}
