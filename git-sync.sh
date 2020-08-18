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

echo "SOURCE=$SOURCE_REPO:$SOURCE_BRANCH"
echo "DESTINATION=$DESTINATION_REPO:$DESTINATION_BRANCH"
echo "Checking git status"
echo "Check that this is being printed"
#git clone "$SOURCE_REPO" /root/source --origin source && cd /root/source
#git remote add destination "$DESTINATION_REPO"

# Pull all branches references down locally so subsequent commands can see them
#git fetch source '+refs/heads/*:refs/heads/*' --update-head-ok

# Print out all branches
#git --no-pager branch -a -vv
echo "Checking git status"
git status
git fetch upstream
git checkout master
git merge upstream/master
git push upstream master
#git rebase upstream/master
#git push -f origin master
#git push origin master
#git push "${DESTINATION_REPO}" master
#git checkout master
#git merge upstream/master
#git push



#git pull $SOURCE_REPO $SOURCE_BRANCH
#git push $DESTINATION_REPO master
#git push destination "${SOURCE_BRANCH}:${DESTINATION_BRANCH}"

