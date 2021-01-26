#!/bin/bash
dpm_main_branch_switcher() {
rm test_branches new_branches branch_list
git branch > test_branches
cat test_branches | while read line
do
    echo "${line##\* }">> new_branches
done
log N "Listing Branches"
current_branch=$(git rev-parse --abbrev-ref HEAD)
log N "Grabbed current branch"
for line in `cat new_branches`
do
    if [ $line = $current_branch ]
        then 
        echo "${line} on">>branch_list
        else 
        echo "${line} off">>branch_list
    fi
done
log N "Branch list built"
dialog_branch=$(cat branch_list | tr '\n' ' ')
branches_count=$(wc -l < new_branches)
log N "Creating Branch switcher dialog"
dialog --no-items --radiolist "Select Branch" $h $w $branches_count $dialog_branch 2> dpm_form
git checkout $(cat dpm_form) | dialog --sleep 2 --progressbox "Updating Package List..." $h $w
dialog --pause "Branch Changed. Program will now exit." $h $w 2
clear
}