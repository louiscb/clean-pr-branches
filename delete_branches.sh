#!/bin/bash

dir=cleanup-tmp

cleanup() {
    # Clean up temporary files
    rm -r $dir
    exit 1
}


trap cleanup SIGINT SIGTERM

# Run the command to get the list of branch names
mkdir $dir

echo "Fetching branches from Github origin"

gh pr list --state merged --json headRefName -L 100000000 -q '.[] | .headRefName' > $dir/branches.txt
gh pr list --state closed --json headRefName -L 100000000 -q '.[] | .headRefName' >> $dir/branches.txt

delete_branch() {
    echo "Processing: $1"
    git push origin --delete "$1"
}

while IFS= read -r branch_name; do
    delete_branch "$branch_name" &
done < $dir/branches.txt

wait

cleanup