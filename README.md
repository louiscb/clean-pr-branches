# Clean PR branches

This script helps you to delete the stale branches in your repo associated with merged or closed pull requests on Github.

## Requirements

- `gh` -> https://cli.github.com

## How to use

1. `cd` into your chosen Github repository
2. Copy the `delete_branches.sh` script somewhere onto your system
3. Provide the appropriate permissions to the script, e.g `chmod +x delete_branches.sh`
4. Run the script passing in the date you want the pull requests to be older than. E.g this will delete the branches of closed or merged PRs created before 2024.

  ```
  ./delete_branches.sh 2024-01-01
  ```
