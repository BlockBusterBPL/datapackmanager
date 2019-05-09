manage_repos(){
  dialog --buildlist "Manage Repositories" 60 40 4 \
  default "Default Repository" on \
  test1 "Test Extra Repo On" on \
  test2 "Test Extra Repo Off" off 2> $TEMP_MANAGER
  yq write repos.yml installed null
  for $1 in $(cat $TEMP_FILE)
  do
    reponame="$(yq read repos.yml refrenced."$1".repourl)"
    git clone "reponame" $reponame
    yq write repos.yml installed.[+] $1
  done
}
repomanager(){
  :
}
