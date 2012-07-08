if git fetch robbyrussell master; then
  echo "Merging with robbyrussell/master"
  git merge robbyrussell/master
fi

git stash && git pull && git push
