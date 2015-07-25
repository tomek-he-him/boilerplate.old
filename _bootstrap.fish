#!/usr/bin/fish

if begin
  test (count $argv) -lt 2
  or test $argv[1] = '--help'
end
  echo 'Usage: ./_bootstrap.sh NAME DESCRIPTION [TITLE [REPO]]'
  exit 0
  end

set args $argv $argv[1]

set name $args[1]
set description $args[2]

if test -z $args[3]; set title $args[3]
else; set title $name
end

if test -z $args[4]; set repo $args[4]
else; set repo (echo git@github.com:tomekwi/$name)
end

echo 'Setting up the repo…'
git remote rename origin boilerplate
and git remote add origin $repo
and if test (count (git branch --list master)) -gt 0
  git branch -D master
  else; true
  end
and git checkout --orphan master
and git commit -m 'Boom!'
and git push --set-upstream origin master
and echo '…done.'
or echo '…failed!'

echo 'Updating name and description…'
and for file in package.json Readme.md
  sed --in-place \
    -e "s/<\!--name-->/$name/g" \
    -e "s/<\!--description-->/$description/g" \
    -e "s/<\!--title-->/$title/g" \
    -e 's/<\!--title-underline-->/'(echo -n $title | sed s/./=/g)'/g' \
    $file
  end
and git commit -m 'Update name and description' package.json Readme.md
and echo '…done.'
or begin
  echo '…failed!'
  false
  end

and npm run _bootstrap

and rm _bootstrap.fish
