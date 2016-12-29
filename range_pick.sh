git cherry-pick -s -x $1
LOG=`git log -n 1 --pretty=format:%s`
BODY=`git log -n 1 --pretty=format:%b`
NEWLOG="UPSTREAM: "$LOG
git commit --amend -m "$NEWLOG" -m "$BODY"
