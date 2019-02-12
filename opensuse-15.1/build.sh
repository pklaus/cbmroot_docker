#!/bin/bash

set -e # fail if any command fails

# build
for TARGET in fairsoft fairroot cbmroot
do
   time docker build \
   --build-arg fairsoft_branch=may18 \
   --build-arg fairroot_branch=v18.0.4 \
   --build-arg cbmroot_release=OCT18 \
   --target $TARGET \
   -t $TARGET .
done

# tag
docker tag fairsoft pklaus/fairsoft:opensuse-15.1_may18
docker tag fairroot pklaus/fairroot:opensuse-15.1_v18.0.4
docker tag cbmroot  pklaus/cbmroot:opensuse-15.1_OCT18
