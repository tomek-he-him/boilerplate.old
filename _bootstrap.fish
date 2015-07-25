#!/usr/bin/fish

if test $argv[1] = '--help'
  echo 'Usage ./bootstrap.sh NAME DESCRIPTION [TITLE]'
  exit 0
  end

set args $argv $argv[1]

set name $args[1]
set description $args[2]
set title $args[3]

echo 'Setting up the repo…'
git branch -D master
and git checkout --orphan master
and git commit -m 'Boom!'
and git remote rename origin boilerplate
and git push --set-upstream origin master
and echo '…done.'

and echo 'Updating name and description…'
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

and npm run _bootstrap

and rm _bootstrap.fish
