#!/bin/bash

set -ex

GITHUB_DEST=$1

if echo $CI_BUILD_REF_NAME | grep private; then
  echo 'sync no private branches'
  exit 0
fi

git checkout $CI_BUILD_REF_NAME
git pull --rebase origin $CI_BUILD_REF_NAME
if git remote | grep github > /dev/null; then git remote rm github; fi
git remote add github $GITHUB_DEST
git push github $CI_BUILD_REF_NAME
