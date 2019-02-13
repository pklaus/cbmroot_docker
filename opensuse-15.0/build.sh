#!/bin/bash

set -e # fail if any command fails

# build
for TARGET in fairsoft fairroot cbmroot
do
   time docker build \
   --build-arg fairsoft_branch=oct17p1 \
   --build-arg fairroot_branch=v-17.10c \
   --build-arg cbmroot_release=OCT18 \
   --target $TARGET \
   -t $TARGET .
done

# tag
docker tag fairsoft pklaus/fairsoft:opensuse-15.0_oct17p1
docker tag fairroot pklaus/fairroot:opensuse-15.0_v-17.10c
docker tag cbmroot  pklaus/cbmroot:opensuse-15.0_OCT18
