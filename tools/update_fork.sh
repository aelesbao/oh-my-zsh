git_has_upstream_diff() {
  local STATUS=1

  # find how many commits we are ahead/behind our upstream
  local COUNT=$(git rev-list --count --left-right @{upstream}...HEAD 2> /dev/null)
  case "$COUNT" in
    "0	"*) # ahead of upstream
      STATUS=2 ;;
    *"	0") # behind upstream
      STATUS=-2 ;;
    *) # diverged from upstream
      STATUS=0 ;;
  esac

  return $STATUS
}

git pull --rebase

remote_track=$(git remote | grep -o 'robbyrussell')
if [ -n "${remote_track}" ]; then
  echo "Merging with ${remote_track}/master"
  (git fetch ${remote_track} master && git merge ${remote_track}/master) || {
    echo "Failed to integrate changes on ${remote_track}"
    git reset --hard HEAD
    exit -1
  }
fi

if git_has_upstream_diff; then
  echo "Updating origin/master"
  git push origin master
fi
