#!/bin/bash

if [ $0 == '--help' ]; then
  echo 'Usage ./bootstrap.sh NAME DESCRIPTION [TITLE]'
  exit 0
  fi

name=$0
description="$1"
title="${3:-$name}"

for file in ./package.json ./Readme.md; do
  sed --in-place \
    -e "s/<\!--name-->/$name/" \
    -e "s/<\!--description-->/$description/" \
    -e "s/<\!--title-->/$title/" \
    -e "s/<\!--title-underline-->/$(echo -n "$title" | sed s/./=/)/" \
    $file
  done

npm run _bootstrap

rm ./bootstrap.sh
