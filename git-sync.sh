#!/bin/sh

set -e

SOURCE_REPO=$1
SOURCE_BRANCH=$2
DESTINATION_REPO=$3
DESTINATION_BRANCH=$4

if ! echo $SOURCE_REPO | grep '.git'
then
  if [[ -n "$SSH_PRIVATE_KEY" ]]
  then
    SOURCE_REPO="git@github.com:${SOURCE_REPO}.git"
    GIT_SSH_COMMAND="ssh -v"
  else
    SOURCE_REPO="https://github.com/${SOURCE_REPO}.git"
  fi
fi
if ! echo $DESTINATION_REPO | grep -E '.git|@'
then
  if [[ -n "$SSH_PRIVATE_KEY" ]]
  then
    DESTINATION_REPO="git@github.com:${DESTINATION_REPO}.git"
    GIT_SSH_COMMAND="ssh -v"
  else
    DESTINATION_REPO="https://github.com/${DESTINATION_REPO}.git"
  fi
fi

git clone "$SOURCE_REPO" /root/source --origin source && cd /root/source
git remote add destination "$DESTINATION_REPO"

# Pull all branches references down locally so subsequent commands can see them
git fetch source '+refs/heads/*:refs/heads/*' --update-head-ok

echo "git status"
git status
git remote add upstream "$SOURCE_REPO"
echo "git status after"
git fetch upstream
echo "git status upstream"
git pull upstream master
echo "git status pull"
git checkout master
git pull "$SOURCE_REPO" master
echo "git pull source"
git merge upstream/master
echo "git merge"
git push upstream master
echo "git push"
git config user.email "jbamrah@woolworths.com.au"
git config user.name "JasWooliesX"
echo "git config"
git pull "$DESTINATION_REPO" master
echo "git pull destination"
git commit -m "Updating from upstream"
echo "git commit"
#git push "$DESTINATION_REPO" master
echo "git destination"
#echo "SOURCE=$SOURCE_REPO:$SOURCE_BRANCH"
#echo "DESTINATION=$DESTINATION_REPO:$DESTINATION_BRANCH"

#git clone "$SOURCE_REPO" /root/source --origin source && cd /root/source
#git remote add destination "$DESTINATION_REPO"

# Pull all branches references down locally so subsequent commands can see them
#git fetch source '+refs/heads/*:refs/heads/*' --update-head-ok

# Print out all branches
#git --no-pager branch -a -vv
#git pull
#git push destination "${SOURCE_BRANCH}:${DESTINATION_BRANCH}"



