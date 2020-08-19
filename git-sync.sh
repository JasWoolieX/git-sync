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
# Pull all branches references down locally so subsequent commands can see them
git fetch source '+refs/heads/*:refs/heads/*' --update-head-ok

# Print out all branches
git --no-pager branch -a -vv

git clone "$DESTINATION_REPO" /root/destination --origin destination
# Pull all branches references down locally so subsequent commands can see them
#git fetch destination '+refs/heads/*:refs/heads/*' --update-head-ok

echo "git Start"
git remote add upstream "$SOURCE_REPO"

#git remote add destination "$DESTINATION_REPO"
cd /root/destination
echo "pwd"
pwd
git config user.email "jbamrah@woolworths.com.au"
git config user.name "JasWooliesX"

git remote --v
git checkout master
echo "checked out master"
git pull "$SOURCE_REPO" master
echo "changes pulled"
git push
echo "git push"
#git pull destination master
git add .
git commit -m "Updating from upstream"
git push
echo "git push 2"
git push destination master
echo "git End"
git remote rm upstream
git remote --verbose

#git push origin master
#git push "${DESTINATION_REPO}" master


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
