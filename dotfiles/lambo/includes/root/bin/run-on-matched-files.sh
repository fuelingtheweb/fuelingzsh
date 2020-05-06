#!/bin/bash

files="$(git diff-tree -r --name-only --no-commit-id ORIG_HEAD HEAD)"

echo "$files" | grep --quiet "$1" && eval "$2"
