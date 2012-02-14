if git fetch robbyrussell master
then
  git merge robbyrussell/master
fi
git push origin master
git pull --rebase
