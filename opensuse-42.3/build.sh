#!/bin/bash

# build
time \
   docker build \
   --build-arg fairsoft_branch=mar17 \
   --build-arg fairroot_branch=v-17.03a \
   --build-arg cbmroot_release=DEC17 \
   -t cbmroot .

# tag
FAIRSOFT_IMAGE=$(docker images --filter "label=build=fairsoft" --format '{{.CreatedAt}}\t{{.ID}}' | sort -nr | head -n 1 | cut -f2)
FAIRROOT_IMAGE=$(docker images --filter "label=build=fairroot" --format '{{.CreatedAt}}\t{{.ID}}' | sort -nr | head -n 1 | cut -f2)
CBMROOT_IMAGE=$( docker images --filter "label=build=cbmroot"  --format '{{.CreatedAt}}\t{{.ID}}' | sort -nr | head -n 1 | cut -f2)
docker tag $FAIRSOFT_IMAGE pklaus/fairsoft:opensuse-42.3_mar17
docker tag $FAIRROOT_IMAGE pklaus/fairroot:opensuse-42.3_v-17.03a
docker tag $CBMROOT_IMAGE  pklaus/cbmroot:opensuse-42.3_DEC17
