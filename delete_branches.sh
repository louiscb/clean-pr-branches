#!/bin/bash

dir=cleanup-tmp

cleanup() {
    # Clean up temporary files
    rm -r $dir
    exit 1
}


trap cleanup SIGINT SIGTERM

# Check if the date argument is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <date>"
    exit 1
fi

date_arg=$1

# Run the command to get the list of branch names
mkdir $dir

echo "Fetching branches from Github origin"

gh pr list --state merged --search "created:<$date_arg" --json headRefName -L 100000 -q '.[] | .headRefName' > $dir/branches.txt
gh pr list --state closed --search "created:<$date_arg" --json headRefName -L 100000 -q '.[] | .headRefName' >> $dir/branches.txt

line_count=$(wc -l < "$file_name")

echo "Found $line_count branches to delete."

delete_branch() {
    echo "Processing: $1"
    git push origin --delete "$1"
}

while IFS= read -r branch_name; do
    delete_branch "$branch_name" &
done < $dir/branches.txt

wait

cleanup