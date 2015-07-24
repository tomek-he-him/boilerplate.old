#!/usr/bin/fish

if test $argv[1] = '--help'
  echo 'Usage ./bootstrap.sh NAME DESCRIPTION [TITLE]'
  exit 0
  end

set args $argv $argv[1]

set name $args[1]
set description $args[2]
set title $args[3]

for file in ./package.json ./Readme.md
  sed --in-place \
    -e "s/<\!--name-->/$name/g" \
    -e "s/<\!--description-->/$description/g" \
    -e "s/<\!--title-->/$title/g" \
    -e 's/<\!--title-underline-->/'(echo -n $title | sed s/./=/)'/g' \
    $file
  end

npm run _bootstrap

rm ./bootstrap.sh
