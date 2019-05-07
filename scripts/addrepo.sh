clone_repo() {
  # Change to repos directory
  git clone $1 # In Dialog
  yq write repos.yml installed.[+] "$1"
}
remove_repo() {
  # Change to repos directory
  rm -rf "$1"
  yq remove repos.yml installed."$1"
  yq remove repos.yml refrenced."$1"
}
add_repo() {
  yq write repos.yml refrenced.[+] "$1"
  clone_repo "$1"
}
