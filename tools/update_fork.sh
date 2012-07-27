git pull

robbyrussell_remote_track=$(git remote | grep -o 'robbyrussell')
if [ -n "${robbyrussell_remote_track}" ]; then
  echo "Merging with robbyrussell/master"
  git fetch -q robbyrussell master && git merge robbyrussell/master && git push -q origin master
fi
