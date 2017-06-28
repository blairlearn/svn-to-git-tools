#!/bin/sh

echo 'Creating Branches.'
for branch in `git branch -r | grep -v trunk | grep -v "@" | grep -v "origin/tags/" | sed 's/  origin\///'`; do
    git branch $branch refs/remotes/origin/$branch ;
done

echo 'Creating Tags.'
for tag in `git branch -r | grep "origin/tags/" | sed 's/  origin\/tags\///'`; do
    git tag -a -m "Converting SVN tags." $tag refs/remotes/origin/tags/$tag
done
