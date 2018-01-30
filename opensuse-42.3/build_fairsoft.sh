#!/bin/bash

time docker build -f Dockerfile.fairsoft --build-arg fairsoft_branch=mar17 -t pklaus/fairsoft:opensuse-42.3_mar17 .
