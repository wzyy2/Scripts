#/bin/bash

git cherry-pick  -x $1
LOG=`git log -n 1 --pretty=format:%s`
BODY=`git log -n 1 --pretty=format:%b`
NEWLOG="UPSTREAM: "$LOG
git commit --amend -m "$NEWLOG" -m "$BODY"

cat << EOF |  git commit -s --amend 
:wq

EOF
