# Clean pull request branches

This script deletes the stale remote branches on your Github repository.
It deletes the branches associated with merged or closed pull requests. 

## Requirements

- `gh` -> https://cli.github.com

## How to use

In your chosen repository, run the script passing in the date you want the pull requests to be older than. E.g this will delete the branches of closed or merged PRs created before 2024.

```
./delete_branches.sh 2024-01-01
```

