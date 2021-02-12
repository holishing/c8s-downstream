#!/usr/bin/env bash

docker build --no-cache --squash -t c8s:ubi8 -f Dockerfile.ubi .
