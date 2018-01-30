#!/bin/bash

set -e # fail if any command fails

# build
for TARGET in fairsoft fairroot cbmroot
do
   time docker build \
   --build-arg fairsoft_branch=mar17 \
   --build-arg fairroot_branch=v-17.03a \
   --build-arg cbmroot_release=DEC17 \
   --target $TARGET \
   -t $TARGET .
done

# tag
docker tag fairsoft pklaus/fairsoft:opensuse-42.3_mar17
docker tag fairroot pklaus/fairroot:opensuse-42.3_v-17.03a
docker tag cbmroot  pklaus/cbmroot:opensuse-42.3_DEC17
