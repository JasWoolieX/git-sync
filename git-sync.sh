#!/bin/sh

set -e

UPSTREAM_REPO=$1
BRANCH_MAPPING=$2
DESTINATION_REPO=$3
DESTINATION_BRANCH=$4
if [[ -z "$UPSTREAM_REPO" ]]; then
  echo "Missing \$UPSTREAM_REPO"
  exit 1
fi

if [[ -z "$BRANCH_MAPPING" ]]; then
  echo "Missing \$SOURCE_BRANCH:\$DESTINATION_BRANCH"
  exit 1
fi

if ! echo $UPSTREAM_REPO | grep '\.git'
then
  UPSTREAM_REPO="https://github.com/${UPSTREAM_REPO}.git"
fi

echo "UPSTREAM_REPO=$UPSTREAM_REPO"
echo "BRANCHES=$BRANCH_MAPPING"

git config --unset-all http."https://github.com/".extraheader
git remote set-url origin ""https://JasWoolieX:jack%40663481@github.com/JasWoolieX/woolworths-mobile-api-automation.git""
git remote add tmp_upstream "$UPSTREAM_REPO"
git fetch tmp_upstream
git pull tmp_upstream master
git remote --verbose
git push origin master
git remote rm tmp_upstream
git remote --verbose
