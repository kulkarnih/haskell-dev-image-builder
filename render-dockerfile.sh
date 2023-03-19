#!/bin/bash

# Generates Dockerfile from template in lts-*/Dockerfile

render() {
sedStr="
  s!%%LTS_VERSION%%!$1!g;
"

sed -r "$sedStr" Dockerfile.template
}

mkdir $1
printf "Rendering Dockerfile for $1"
render $1 > $1/Dockerfile
printf "\n\n********************\n"
cat $1/Dockerfile
printf "********************\n"
