#!/bin/bash

SAVE_PATH="studosi-fer-dwnld"
TOTAL_DOWNLOADED=0

mkdir -p $SAVE_PATH && cd $SAVE_PATH

for page in {1..10}
do
    LINK="https://api.github.com/users/studosi-fer/repos?per_page=100&page=$page"
    REPOS=$(curl -s $LINK| jq | grep "clone_url" | grep -o "htt.*git")

    for repo in $REPOS
    do
        current=$((TOTAL_DOWNLOADED + 1))
        repo_name=$(echo $repo |  awk -F'/' '{ print $5 }')

        echo "Downloading #$current $repo_name"
        git clone $repo

        TOTAL_DOWNLOADED=$((TOTAL_DOWNLOADED + 1))
    done
done
