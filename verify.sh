for i in $(find ./extensions/source -type f -print); do shellcheck $i; done
