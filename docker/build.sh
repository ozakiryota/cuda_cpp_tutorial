#!/bin/bash

image="cuda_cpp_tutorial"
tag="latest"

docker build . \
    -t $image:$tag \
    --build-arg CACHEBUST=$(date +%s)