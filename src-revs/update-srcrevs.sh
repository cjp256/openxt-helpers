#!/bin/bash

set -e

REPO_LIST="$1"

if [[ ! -f $REPO_LIST ]]; then
    echo "please feed me repo list!"
    exit 1
fi

BRANCH_NAME="$2"

if [[ -z $BRANCH_NAME ]]; then
    echo "no branch name specified, defaulting to use AUTOREV!"
fi

cat $REPO_LIST | sed '/^#/d' | while read -r line
do
    filename=$(echo $line | cut -f 1 -d "|")
    repo=$(echo $line | cut -f 2 -d "|")
    url=$(echo $line | cut -f 3 -d "|")
    srcrev_name=$(echo $line | cut -f 4 -d "|")

    # force git mode for speed
    url=$(echo $url | sed 's/https/git/g')

    #echo "filename=$filename repo=$repo url=$url srcrev_name=$srcrev_name"

    if [[ -n $BRANCH_NAME ]]; then
        ls_remote=$(git ls-remote $url $BRANCH_NAME)
        #echo "ls-remote = $ls_remote"
        srcrev=$(echo $ls_remote | cut -f 1 -d " ")

        echo "repo=$repo url=$url srcrev_name=$srcrev_name srcrev=$srcrev"

        continue

        # update with latest srcrev
        sed -i "s/${srcrev_name}.*/${srcrev_name} = \"$srcrev\"/g" $filename
    else
        # update with 'AUTOREV'
        sed -i "s/${srcrev_name}.*/${srcrev_name} = \"\$\{AUTOREV\}\"/g" $filename
    fi
done
