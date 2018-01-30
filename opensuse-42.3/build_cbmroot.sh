#!/bin/bash

time docker build -f Dockerfile.cbmroot --build-arg cbmroot_release=DEC17 -t pklaus/cbmroot:opensuse-42.3_DEC17 .
