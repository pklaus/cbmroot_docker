#!/bin/bash

time docker build -f Dockerfile.fairroot --build-arg fairroot_branch=v-17.03a -t pklaus/fairroot:opensuse-42.3_v-17.03a .
