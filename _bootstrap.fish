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

if test -n $args[3]; set title $args[3]
else; set title $name
end

if test -n $args[4]; set repo $args[4]
else; set repo (echo git@github.com:tomekwi/$name)
end

echo '\nSetting up the repo…'
git remote rename origin boilerplate
and git remote add origin $repo
and if test (count (git branch --list master)) -gt 0
  git branch -D master
  else; true
  end
and git checkout --orphan master
and git commit -m 'Boom!'
and git remote update --prune
and git branch --set-upstream-to=origin/master
and echo '…done.'
or echo '…failed!'

echo '\nUpdating name and description…'
for file in package.json Readme.md
  sed --in-place \
    -e "s/<\!--name-->/$name/g" \
    -e "s/<\!--description-->/$description/g" \
    -e "s/<\!--title-->/$title/g" \
    -e 's/<\!--title-underline-->/'(echo -n $title | sed s/./=/g)'/g' \
    -e "s|<\!--repo-->|$repo|g" \
    $file
  end
and git add --patch
and git commit -m 'Update name and description' package.json Readme.md
and echo '…done.'
or echo '…failed!'

echo '\nBootstrapping dependencies…'
npm run _bootstrap
and git add --patch
and git commit -m 'Bootstrap dependencies'
and echo '…done.'
or echo '…failed!'

echo '\nRemoving the bootstrap script…'
rm _bootstrap.fish
and git add --patch
and git commit -m 'Remove the bootstrap script'
and echo '…done.'
or echo '…failed!'
