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
